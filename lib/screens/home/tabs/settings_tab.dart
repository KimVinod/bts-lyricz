import 'package:bts_lyrics_app/screens/faq/faq_screen.dart';
import 'package:bts_lyrics_app/services/settings_service.dart';
import 'package:bts_lyrics_app/utils/widgets/settings_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => <Widget>[
        SliverAppBar(
          floating: true,
          snap: true,
          pinned: true,
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          title: Text("Settings", style: GoogleFonts.openSans(fontSize: 22, fontWeight: FontWeight.bold)),
        ),
      ],
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: AnimationLimiter(
          child: Column(
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 500),
              childAnimationBuilder: (widget) => SlideAnimation(
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: [
                SettingsCard(
                  icon: Icons.color_lens_outlined,
                  title: "Set app theme",
                  subtitle: "Change the look and feel of the app",
                  onTap: () => SettingsService.openThemeDialog(context),
                ),
                SettingsCard(
                  icon: Icons.notifications_none,
                  title: "Turn ON/OFF BTS related notifications",
                  subtitle: "Btw I rarely send these ~.~",
                  onTap: () => SettingsService.openNotifications(),
                ),
                SettingsCard(
                  icon: Icons.system_update,
                  title: "Check for Updates",
                  subtitle: "Get latest songs and improvements",
                  onTap: () => SettingsService.checkForUpdates(context),
                ),
                SettingsCard(
                  icon: Icons.question_mark,
                  title: "FAQ",
                  subtitle: "Got stuck somewhere? This might help you",
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FAQScreen())),
                ),
                SettingsCard(
                  icon: Icons.notes,
                  title: "Version Notes",
                  subtitle: "Check out upcoming features and previous version notes",
                  onTap: () => SettingsService.openVersionNotes(),
                ),
                SettingsCard(
                  icon: Icons.bug_report_outlined,
                  title: "Found a Bug? Suggestions?",
                  subtitle: "Feel free to give your inputs as it helps a lot!",
                  onTap: () => SettingsService.showFoundBugDialog(context: context),
                ),
                SettingsCard(
                  icon: Icons.star_rate_outlined,
                  title: "Rate on Google Play",
                  subtitle: "Thankuuu in advance :')",
                  onTap: () => SettingsService.rateMe(),
                ),
                SettingsCard(
                  icon: Icons.share,
                  title: "Share",
                  subtitle: "Share to other armys as well  >.<",
                  onTap: () => SettingsService.share(),
                ),
                SettingsCard(
                  icon: Icons.code,
                  title: "Source Code",
                  subtitle: "Get to see all the coding work here",
                  onTap: () => SettingsService.showSourceCode(),
                ),
                SettingsCard(
                  icon: Icons.apps,
                  title: "App info",
                  subtitle: "Some extra stuff",
                  onTap: () => SettingsService.showAppInfo(context: context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
