import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/submission_controller.dart';
import '../models/assignment_model.dart';
import '../models/submission_model.dart';

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

    if (widget.assignment.attachmentUrl.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "No attachment available.",
          ),
        ),
      );

      return;
    }

    final url =
    Uri.parse(widget.assignment.attachmentUrl);

    if (await canLaunchUrl(url)) {

      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );

    } else {

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Unable to open attachment.",
          ),
        ),
      );
    }
  }

  Future<void> uploadSubmission() async {

    final result =
    await FilePicker.platform.pickFiles(

      allowMultiple: false,

      type: FileType.custom,

      allowedExtensions: [
        "pdf",
        "doc",
        "docx",
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

    try {

      await SubmissionController.uploadSubmission(

        assignmentId:
        widget.assignment.id,

        studentName:
        "Student",

        file: file,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Assignment submitted successfully.",
          ),
        ),
      );

    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
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

    return Dialog(

        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(22),
        ),

        child: Padding(

            padding:
            const EdgeInsets.all(22),

            child: SingleChildScrollView(

                child: Column(

                    mainAxisSize:
                    MainAxisSize.min,

                    crossAxisAlignment:
                    CrossAxisAlignment.start,

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
                widget.assignment.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 24),

            buildTile(
              Icons.book,
              "Module",
              widget.assignment.module,
            ),

            buildTile(
              Icons.person,
              "Lecturer",
              widget.assignment.lecturer,
            ),

            buildTile(
              Icons.school,
              "Semester",
              widget.assignment.semester,
            ),

            buildTile(
              Icons.calendar_today,
              "Deadline",
              DateFormat(
                "dd MMM yyyy",
              ).format(
                widget.assignment.deadline,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Description",
              style: TextStyle(
                fontSize: 17,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              widget.assignment.description,
              style: const TextStyle(
                height: 1.6,
              ),
            ),

            const SizedBox(height: 24),

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
                      CrossAxisAlignment
                          .start,
                      children: [
                    Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius:
                      BorderRadius.circular(16),
                    ),
                    child: submission == null
                        ? const Row(
                      children: [

                        Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),

                        SizedBox(width: 10),

                        Text(
                          "Not Submitted",
                          style: TextStyle(
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                      ],
                    )
                        : Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        const Row(
                          children: [

                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),

                            SizedBox(width: 10),

                            Text(
                              "Submitted",
                              style: TextStyle(
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),

                          ],
                        ),

                        const SizedBox(height: 12),

                        Text(
                          "File : ${submission.fileName}",
                        ),

                        const SizedBox(height: 6),

                        Text(
                          "Submitted : "
                              "${DateFormat("dd MMM yyyy • hh:mm a").format(submission.submittedAt)}",
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
                      ),

                      label: Text(

                      uploading

                      ? "Uploading..."

                          : submission == null

                      ? "Upload Submission"

                          : "Replace Submission",

                      ),

                      onPressed:

                      uploading

                      ? null

                          : uploadSubmission,

                      ),
                      ),
                        const SizedBox(height: 12),

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
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  value,
                  style: const TextStyle(
                    fontWeight:
                    FontWeight.w600,
                    fontSize: 16,
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getPriorityText() {

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