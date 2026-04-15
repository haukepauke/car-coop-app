import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/extensions/string_extensions.dart';
import '../../../core/extensions/exception_extensions.dart';
import '../../../data/api/message_api.dart';
import '../../../data/models/message.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/car_provider.dart';
import '../../../providers/message_provider.dart';
import '../../../providers/settings_provider.dart';
import '../../widgets/common/page_header.dart';
import '../../widgets/common/user_avatar.dart';
import '../../widgets/common/friendly_empty_state.dart';

class MessagesScreen extends ConsumerStatefulWidget {
  const MessagesScreen({super.key});

  @override
  ConsumerState<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends ConsumerState<MessagesScreen> {
  final List<Message> _messages = [];
  int _page = 1;
  int _totalItems = 0;
  bool _initialLoading = true;
  bool _loadingMore = false;
  String? _error;

  static const _pageSize = 10;

  int? get _carId => ref.read(selectedCarIdProvider);

  bool get _hasMore => _messages.length < _totalItems;

  List<Message> get _sorted {
    final sorted = List<Message>.from(_messages);
    sorted.sort((a, b) {
      if (a.isSticky && !b.isSticky) return -1;
      if (!a.isSticky && b.isSticky) return 1;
      return b.createdAt.compareTo(a.createdAt);
    });
    return sorted;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadPage(1));
  }

  Future<void> _loadPage(int page) async {
    final carId = _carId;
    if (carId == null) return;

    if (page == 1) {
      setState(() { _initialLoading = true; _error = null; });
    } else {
      setState(() => _loadingMore = true);
    }

    try {
      final result = await ref.read(messageApiProvider).getMessages(
        carIri: toIri('cars', carId),
        page: page,
        itemsPerPage: _pageSize,
      );
      setState(() {
        if (page == 1) _messages.clear();
        _messages.addAll(result.members);
        _totalItems = result.totalItems;
        _page = page;
      });
    } catch (e) {
      setState(() => _error = e.toLocalizedMessage(context));
    } finally {
      setState(() { _initialLoading = false; _loadingMore = false; });
    }
  }

  Future<void> _refresh() async {
    ref.invalidate(messagesProvider(_carId!));
    await _loadPage(1);
  }

  @override
  Widget build(BuildContext context) {
    final carId = ref.watch(selectedCarIdProvider);
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();

    if (carId == null) return Center(child: Text(l10n.noCarSelected));

    final apiUrl = ref.watch(apiUrlProvider) ?? '';
    final dateFmt = DateFormat.MMMd(locale).add_Hm();

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(icon: Icons.forum_outlined, title: l10n.messagesTitle),
          Expanded(child: _buildBody(apiUrl, dateFmt, l10n)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/messages/new'),
        child: const Icon(Icons.edit_outlined),
      ),
    );
  }

  Widget _buildBody(String apiUrl, DateFormat dateFmt, AppLocalizations l10n) {
    if (_initialLoading) return const Center(child: CircularProgressIndicator());
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_error!),
            const SizedBox(height: 12),
            FilledButton(onPressed: () => _loadPage(1), child: Text(l10n.retry)),
          ],
        ),
      );
    }
    if (_messages.isEmpty) {
      return FriendlyEmptyState(
        icon: Icons.forum_outlined,
        title: l10n.noMessages,
        actionLabel: l10n.newMessage,
        onAction: () => context.push('/messages/new'),
      );
    }

    final sorted = _sorted;
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 96),
        itemCount: sorted.length + (_hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == sorted.length) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Center(
                child: _loadingMore
                    ? const CircularProgressIndicator()
                    : OutlinedButton(
                        onPressed: () => _loadPage(_page + 1),
                        child: Text(l10n.loadMore),
                      ),
              ),
            );
          }
          final m = sorted[index];
          return _MessageCard(m: m, apiUrl: apiUrl, dateFmt: dateFmt);
        },
      ),
    );
  }
}

class _MessageCard extends StatelessWidget {
  const _MessageCard({required this.m, required this.apiUrl, required this.dateFmt});

  final Message m;
  final String apiUrl;
  final DateFormat dateFmt;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      color: m.isSticky ? Theme.of(context).colorScheme.secondaryContainer : null,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (m.isSticky) ...[
                  Icon(Icons.push_pin, size: 14,
                      color: Theme.of(context).colorScheme.secondary,),
                  const SizedBox(width: 4),
                ],
                if (m.author != null)
                  UserAvatar(user: m.author!, radius: 16, apiUrl: apiUrl),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    m.author?.name ?? 'System',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Text(
                  dateFmt.format(m.createdAt),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Html(data: m.content.toLocalizedContent(context)),
            if (m.photos.isNotEmpty) ...[
              const SizedBox(height: 8),
              SizedBox(
                height: 80,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: m.photos.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, i) => ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      '$apiUrl/uploads/messages/${m.photos[i]}',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
