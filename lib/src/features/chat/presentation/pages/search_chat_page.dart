import 'package:un4seen/src/features/chat/presentation/controller/chat_controller.dart';

import '../../../../src_export.dart';
import '../widgets/discovered_channel_tile.dart';
import '../widgets/rider_search_tile.dart';

class SearchChatPage extends StatefulWidget {
  const SearchChatPage({super.key});

  @override
  State<SearchChatPage> createState() => _SearchChatPageState();
}

class _SearchChatPageState extends State<SearchChatPage> {
  final controller = Get.find<ChatController>();
  final searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initial fetch without params as requested
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.globalSearch("");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search & Discover"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: CustomTextField(
              textEditingController: searchCtrl,
              hintText: "Search riders or channels...",
              prefixIcon: const Icon(Icons.search),
              onChanged: (val) => controller.globalSearch(val),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.globalSearch(searchCtrl.text),
        child: Obx(() {
          final isInitialLoading = controller.isSearchLoading.value &&
              controller.searchRiderResults.isEmpty &&
              controller.discoveredChannels.isEmpty;
          final hasResults = controller.discoveredChannels.isNotEmpty ||
              controller.searchRiderResults.isNotEmpty;

          return CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              if (isInitialLoading)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (!hasResults)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: CustomText("No results found", color: Colors.grey),
                  ),
                )
              else ...[
                if (controller.discoveredChannels.isNotEmpty) ...[
                  _buildHeader("Discovered Channels"),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => DiscoveredChannelTile(
                        model: controller.discoveredChannels[index],
                      ),
                      childCount: controller.discoveredChannels.length,
                    ),
                  ),
                ],
                if (controller.searchRiderResults.isNotEmpty)
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => RiderSearchTile(
                        model: controller.searchRiderResults[index],
                      ),
                      childCount: controller.searchRiderResults.length,
                    ),
                  ),
              ],
              const SliverToBoxAdapter(child: SizedBox(height: 50)),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildHeader(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
        child: CustomText(
          title,
          variant: TextVariant.titleMedium,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
