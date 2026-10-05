import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  Widget buildSection({
    required BuildContext context,
    required bool isDark,
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Card(
      color: isDark
          ? const Color(0xFF232323)
          : Colors.white,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: ExpansionTile(
        iconColor: const Color(0xFF0D47A1),
        collapsedIconColor: const Color(0xFF0D47A1),

        leading: Icon(
          icon,
          color: const Color(0xFF0D47A1),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        childrenPadding:
        const EdgeInsets.fromLTRB(
          20,
          0,
          20,
          20,
        ),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              content,
              style: TextStyle(
                height: 1.6,
                color: isDark
                    ? Colors.grey.shade300
                    : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness ==
            Brightness.dark;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Privacy Policy"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
              children: [

          Card(
          color: isDark
          ? const Color(0xFF232323)
              : Colors.white,
          elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
              side: BorderSide(
                color: isDark
                    ? Colors.grey.shade800
                    : Colors.grey.shade300,
              ),
            ),
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Row(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D47A1)
                        .withValues(alpha: 0.12),
                    borderRadius:
                    BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    Icons.verified_user,
                    color: Color(0xFF0D47A1),
                    size: 34,
                  ),
                ),

                const SizedBox(width: 18),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your Privacy Matters",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight:
                          FontWeight.bold,
                          color: isDark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "UniSphere is committed to protecting your personal information and maintaining your privacy while using our application.",
                        style: TextStyle(
                          height: 1.6,
                          color: isDark
                              ? Colors.grey.shade300
                              : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

      const SizedBox(height: 18),

      buildSection(
        context: context,
        isDark: isDark,
        icon: Icons.person_outline,
        title: "Information We Collect",
        content:
        "• Full Name\n"
            "• University Email\n"
            "• Phone Number\n"
            "• Faculty\n"
            "• Academic Year\n"
            "• Profile Picture (Optional)",
      ),

      buildSection(
        context: context,
        isDark: isDark,
        icon: Icons.settings,
        title: "How We Use Your Information",
        content:
        "Your information is used to create your account, manage your profile, enable Marketplace and Lost & Found services, and improve your overall experience within UniSphere.",
      ),
      buildSection(
        context: context,
        isDark: isDark,
        icon: Icons.security,
        title: "Data Security",
        content:
        "UniSphere securely stores your information using Firebase Authentication and Cloud Firestore. We apply reasonable security measures to protect your personal data from unauthorized access, modification, or disclosure.",
      ),

      buildSection(
        context: context,
        isDark: isDark,
        icon: Icons.groups_outlined,
        title: "Information Sharing",
        content:
        "We do not sell, trade, or rent your personal information to third parties. Your information will only be shared when required by law or to provide essential application services.",
      ),

      buildSection(
        context: context,
        isDark: isDark,
        icon: Icons.verified_user_outlined,
        title: "Your Rights",
        content:
        "You have the right to update your profile information, request corrections, and manage your personal details through your UniSphere account at any time.",
      ),

      buildSection(
        context: context,
        isDark: isDark,
        icon: Icons.email_outlined,
        title: "Contact Us",
        content:
        "If you have any questions, concerns, or suggestions regarding this Privacy Policy, please contact the UniSphere Development Team through the official university communication channels.",
      ),

      const SizedBox(height: 20),

      Card(
        color: isDark
            ? Colors.green.shade900.withValues(alpha: 0.25)
            : Colors.green.shade50,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(
            color: isDark
                ? Colors.grey.shade800
                : Colors.grey.shade300,
          ),
        ),
        child: const ListTile(
          leading: Icon(
            Icons.shield,
            color: Colors.green,
          ),
          title: Text(
            "Your data is protected",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "UniSphere uses Firebase Authentication and Cloud Firestore to securely protect your personal information.",
          ),
        ),
      ),

      const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0D47A1),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.check_circle_outline),
                    label: const Text(
                      "I Understand",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
          ),
        ),
    );
  }
}