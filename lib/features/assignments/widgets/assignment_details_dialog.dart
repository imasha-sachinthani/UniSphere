import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/submission_controller.dart';
import '../models/assignment_model.dart';
import '../models/submission_model.dart';
import '../screens/pdf_viewer_screen.dart';

class AssignmentDetailsDialog extends StatefulWidget {
  final AssignmentModel assignment;

  const AssignmentDetailsDialog({
    super.key,
    required this.assignment,
  });

  @override
  State<AssignmentDetailsDialog> createState() =>
      _AssignmentDetailsDialogState();
}

class _AssignmentDetailsDialogState
    extends State<AssignmentDetailsDialog> {

  bool uploading = false;

  Future<void> downloadAssignment() async {
    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PdfViewerScreen(
          title: "Software Process Management Assignment",
          assetPath:
          "assets/assignments/Software_Process_management_Assignment_01.pdf",
        ),
      ),
    );
  }

  Future<void> openSubmission(
      SubmissionModel submission) async {

    if (submission.fileUrl.isEmpty) return;

    final url = Uri.parse(submission.fileUrl);

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  Future<void> uploadSubmission() async {

    final result =
    await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: const [
        "pdf",
        "doc",
        "docx",
        "ppt",
        "pptx",
        "zip",
      ],
    );

    if (result == null) {
      return;
    }

    final file =
    File(result.files.single.path!);

    setState(() {
      uploading = true;
    });

    try {       await SubmissionController.uploadSubmission(
      assignmentId: widget.assignment.id,
      studentName: "Student",
      file: file,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Assignment submitted successfully.",
        ),
      ),
    );

    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );

    } finally {

      if (mounted) {
        setState(() {
          uploading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final isDark =
        Theme.of(context).brightness ==
            Brightness.dark;

    return Dialog(

        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(24),
        ),

        child: Container(

            width: 500,

            padding: const EdgeInsets.all(24),

            decoration: BoxDecoration(

              color: isDark
                  ? const Color(0xFF1E1E1E)
                  : Colors.white,

              borderRadius:
              BorderRadius.circular(24),
            ),

            child: SingleChildScrollView(

              child: Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                mainAxisSize: MainAxisSize.min,

                children: [

              Center(

              child: CircleAvatar(

              radius: 34,

                backgroundColor:
                Colors.blue.shade100,

                child: const Icon(

                  Icons.assignment,

                  size: 34,

                  color: Colors.blue,
                ),
              ),
            ),

            const SizedBox(height: 18),

            Center(

                child: Text(
                  widget.assignment.title,                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
            ),

            const SizedBox(height: 25),

            buildTile(
              Icons.book,
              "Module",
              widget.assignment.module,
              isDark,
            ),

            buildTile(
              Icons.person,
              "Lecturer",
              widget.assignment.lecturer,
              isDark,
            ),

            buildTile(
              Icons.school,
              "Semester",
              widget.assignment.semester,
              isDark,
            ),

            buildTile(
              Icons.calendar_today,
              "Deadline",
              DateFormat(
                "dd MMM yyyy",
              ).format(
                widget.assignment.deadline,
              ),
              isDark,
            ),

            const SizedBox(height: 24),

            Text(
              "Description",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark
                    ? Colors.white
                    : Colors.black,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              widget.assignment.description,
              style: TextStyle(
                height: 1.6,
                color: isDark
                    ? Colors.grey.shade300
                    : Colors.black87,
              ),
            ),

            const SizedBox(height: 28),

            StreamBuilder<SubmissionModel?>(
                stream:
                SubmissionController
                    .getSubmission(
                  widget.assignment.id,
                ),

                builder:
                    (context, snapshot) {

                  final submission =
                      snapshot.data;

                  return Column(

                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                    Container(

                    width: double.infinity,

                    padding:
                    const EdgeInsets.all(
                      16,
                    ),

                    decoration:
                    BoxDecoration(

                      color: isDark
                          ? const Color(
                        0xFF2A2A2A,
                      )
                          : Colors.grey
                          .shade100,

                      borderRadius:
                      BorderRadius.circular(
                        18,
                      ),
                    ),                        child: submission == null

                      ? Row(
                    children: [

                      const Icon(
                        Icons.cancel,
                        color: Colors.red,
                      ),

                      const SizedBox(width: 12),

                      Text(
                        "Not Submitted",
                        style: TextStyle(
                          fontWeight:
                          FontWeight.bold,
                          color: isDark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ],
                  )

                      : Column(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                    children: [

                      Row(
                        children: [

                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),

                          const SizedBox(width: 12),

                          Text(
                            "Submitted",
                            style: TextStyle(
                              fontWeight:
                              FontWeight.bold,
                              color: isDark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      Text(
                        "📄 ${submission.fileName}",
                        style: TextStyle(
                          color: isDark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "Submitted : ${DateFormat("dd MMM yyyy • hh:mm a").format(submission.submittedAt)}",
                        style: TextStyle(
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade700,
                        ),
                      ),

                      const SizedBox(height: 15),

                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          icon: const Icon(
                            Icons.open_in_new,
                          ),
                          label: const Text(
                            "Open My Submission",
                          ),
                          onPressed: () =>
                              openSubmission(
                                submission,
                              ),
                        ),
                      ),
                    ],
                  ),
                  ),

                      const SizedBox(height: 24),

                      SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                      icon: const Icon(
                      Icons.download,
                      ),
                      label: const Text(
                      "Download Assignment",
                      ),
                      onPressed:
                      downloadAssignment,
                      ),
                      ),

                      const SizedBox(height: 12),

                      SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                      icon: uploading
                      ? const SizedBox(
                      width: 18,
                      height: 18,
                      child:
                      CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                      ),
                      )
                          : const Icon(
                      Icons.upload_file,
                      ),                          label: Text(
                        uploading
                            ? "Uploading..."
                            : submission == null
                            ? "Upload Submission"
                            : "Replace Submission",
                      ),

                        onPressed: uploading
                            ? null
                            : uploadSubmission,
                      ),
                      ),

                      if (submission != null) ...[

                        const SizedBox(height: 12),

                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(

                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),

                            label: const Text(
                              "Delete Submission",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),

                            onPressed: () async {

                              final confirm =
                              await showDialog<bool>(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text(
                                    "Delete Submission",
                                  ),
                                  content: const Text(
                                    "Are you sure you want to delete your submission?",
                                  ),
                                  actions: [

                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(
                                          context,
                                          false,
                                        );
                                      },
                                      child:
                                      const Text("Cancel"),
                                    ),

                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(
                                          context,
                                          true,
                                        );
                                      },
                                      child:
                                      const Text("Delete"),
                                    ),
                                  ],
                                ),
                              );

                              if (confirm == true) {
                                await SubmissionController
                                    .deleteSubmission(
                                  submission,
                                );
                              }
                            },
                          ),
                        ),
                      ],

                      const SizedBox(height: 16),

                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Close",
                          ),
                        ),
                      ),
                    ],
                  );
                    },
            ),
                ],
              ),
            ),
        ),
    );
  }

  Widget buildTile(
      IconData icon,
      String title,
      String value,
      bool isDark,
      ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16,
      ),
      child: Row(
        children: [

          Icon(
            icon,
            color: Colors.blue,
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: TextStyle(
                    color: isDark
                        ? Colors.grey.shade400
                        : Colors.grey,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                    FontWeight.w600,
                    color: isDark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getPriorityText() {
    switch (widget.assignment.priority) {
      case 3:
        return "High";
      case 2:
        return "Medium";
      default:
        return "Low";
    }
  }
}