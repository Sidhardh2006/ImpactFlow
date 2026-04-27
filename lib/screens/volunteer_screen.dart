import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/need_provider.dart';

class VolunteerScreen extends StatelessWidget {
  const VolunteerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Priority Needs')),
      body: Consumer<NeedProvider>(
        builder: (context, provider, child) {
          final needs = provider.needs;

          if (needs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.auto_awesome,
                      size: 80, color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
                  const SizedBox(height: 20),
                  const Text(
                    'All clear!',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'No urgent needs at the moment.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            itemCount: needs.length,
            itemBuilder: (context, index) {
              final need = needs[index];
              final priorityColor = _getPriorityColor(need.priorityScore);
              final isRecommended = index < 3; // Top 3 are recommended

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (index == 0) ...[
                    const Padding(
                      padding: EdgeInsets.only(bottom: 16, top: 10),
                      child: Row(
                        children: [
                          Icon(Icons.auto_awesome, size: 20, color: Colors.amber),
                          SizedBox(width: 8),
                          Text(
                            'RECOMMENDED FOR YOU',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  if (index == 3) ...[
                    const Padding(
                      padding: EdgeInsets.only(bottom: 16, top: 10),
                      child: Text(
                        'OTHER NEEDS',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: priorityColor.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Column(
                        children: [
                          Container(
                            height: 6,
                            width: double.infinity,
                            color: priorityColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  Row(
                                    children: [
                                      if (isRecommended)
                                        Container(
                                          margin: const EdgeInsets.only(right: 8),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: Colors.amber.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(
                                                color: Colors.amber.withOpacity(0.5)),
                                          ),
                                          child: const Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Icons.bolt,
                                                  size: 14, color: Colors.amber),
                                              SizedBox(width: 4),
                                              Text(
                                                'AI RECOMMENDED',
                                                style: TextStyle(
                                                  color: Colors.orange,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      if (need.isAiVerified)
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: Colors.blue.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(
                                                color: Colors.blue.withOpacity(0.5)),
                                          ),
                                          child: const Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Icons.verified,
                                                  size: 14, color: Colors.blue),
                                              SizedBox(width: 4),
                                              Text(
                                                'AI VERIFIED',
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  if (isRecommended)
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 12.0),
                                      child: Text(
                                        'Recommended due to high urgency and large number of people affected',
                                        style: TextStyle(
                                          color: Colors.amber,
                                          fontSize: 12,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        need.title,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: priorityColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        'Score: ${need.priorityScore}',
                                        style: TextStyle(
                                          color: priorityColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  need.description,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black.withOpacity(0.7),
                                    height: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    _buildInfoChip(Icons.category_rounded,
                                        need.category, Colors.purple),
                                    const SizedBox(width: 12),
                                    _buildInfoChip(Icons.warning_amber_rounded,
                                        'Urgency ${need.urgency}', Colors.orange),
                                    const SizedBox(width: 12),
                                    _buildInfoChip(Icons.people_outline_rounded,
                                        '${need.peopleAffected} Affected', Colors.blue),
                                  ],
                                ),
                                const Divider(height: 40),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Interested in "${need.title}"'),
                                              const Text(
                                                'You are a strong match for this task based on urgency and impact',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          backgroundColor:
                                              Theme.of(context).colorScheme.primary,
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).colorScheme.surface,
                                      foregroundColor:
                                          Theme.of(context).colorScheme.primary,
                                      side: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.2)),
                                      elevation: 0,
                                    ),
                                    child: const Text('Express Interest'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Color _getPriorityColor(int score) {
    if (score >= 20) return Colors.redAccent;
    if (score >= 10) return Colors.orangeAccent;
    return Colors.greenAccent;
  }

  Widget _buildInfoChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
