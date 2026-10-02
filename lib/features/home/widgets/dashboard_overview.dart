import 'package:flutter/material.dart';

class DashboardOverview extends StatelessWidget {
  const DashboardOverview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [

        Row(

          children: [

            Expanded(

              child: _DashboardCard(

                title: "Today's Classes",

                value: "05",

                subtitle: "Scheduled",

                icon:
                Icons.calendar_today_rounded,

                color: Colors.blue,

              ),

            ),

            const SizedBox(width: 16),

            Expanded(

              child: _DashboardCard(

                title: "Assignments",

                value: "03",

                subtitle: "Pending",

                icon:
                Icons.assignment_rounded,

                color: Colors.orange,

              ),

            ),

          ],

        ),

        const SizedBox(height: 16),

        Row(

          children: [

            Expanded(

              child: _DashboardCard(

                title: "Marketplace",

                value: "18",

                subtitle: "Products",

                icon:
                Icons.storefront_rounded,

                color: Colors.deepPurple,

              ),

            ),

            const SizedBox(width: 16),

            Expanded(

              child: _DashboardCard(

                title: "Lost & Found",

                value: "07",

                subtitle: "Recent Posts",

                icon:
                Icons.search_rounded,

                color: Colors.red,

              ),

            ),

          ],

        ),

      ],

    );

  }

}

class _DashboardCard extends StatelessWidget {

  final String title;

  final String value;

  final String subtitle;

  final IconData icon;

  final Color color;

  const _DashboardCard({

    required this.title,

    required this.value,

    required this.subtitle,

    required this.icon,

    required this.color,

  });

  @override
  Widget build(BuildContext context) {

    return Container(

        padding:
        const EdgeInsets.all(18),

        decoration: BoxDecoration(

          color: Colors.white,

          borderRadius:
          BorderRadius.circular(22),

          border: Border.all(

            color: Colors.grey.shade200,

          ),

          boxShadow: [

            BoxShadow(

              color:
              Colors.black.withValues(
                alpha: 0.04,
              ),

              blurRadius: 12,

              offset:
              const Offset(0, 5),

            ),

          ],

        ),

        child: Column(

            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [

                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        icon,
                        color: color,
                        size: 28,
                      ),
                    ),

                    const Spacer(),

                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            subtitle,
                            maxLines: 1,
                            style: TextStyle(
                              color: color,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),

              ],
            ),
              const SizedBox(height: 18),

              Text(

                value,

                style: TextStyle(

                  color: color,

                  fontSize: 34,

                  fontWeight:
                  FontWeight.bold,

                ),

              ),

              const SizedBox(height: 6),

              Text(

                title,

                style: const TextStyle(

                  fontWeight:
                  FontWeight.w600,

                  fontSize: 15,

                ),

              ),

              const SizedBox(height: 14),

              LinearProgressIndicator(

                value: 0.70,

                minHeight: 6,

                borderRadius:
                BorderRadius.circular(20),

                backgroundColor:
                Colors.grey.shade200,

                valueColor:
                AlwaysStoppedAnimation(
                  color,
                ),

              ),

              const SizedBox(height: 8),

              Align(

                alignment:
                Alignment.centerRight,

                child: Text(

                  "Updated just now",

                  style: TextStyle(

                    color:
                    Colors.grey.shade500,

                    fontSize: 11,

                  ),

                ),

              ),

            ],

        ),

    );

  }

}