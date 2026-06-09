import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mybend/core/extensions/context_extensions.dart';
import 'package:mybend/core/themes/app_theme.dart';
import 'package:mybend/features/babel/models/content.dart';
import 'package:mybend/features/babel/widgets/movie_poster_preview.dart';
import 'package:mybend/features/babel/widgets/star_rating.dart';

class AddContentScreen extends StatefulWidget {
  const AddContentScreen({super.key, required this.callback});

  final void Function(Content content) callback;
  
  @override
  State<AddContentScreen> createState() => _AddContentScreenState();
}

class _AddContentScreenState extends State<AddContentScreen> {
  ContentType selectedType = ContentType.book;
  ContentStatus selectedStatus = ContentStatus.todo;
  String name = '';
  String comments = '';
  int rating = 0;
  String? imageUrl;

  Future<void> _save() async {
    if (name.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez remplir le nom')),
      );
      return;
    }

    if (rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez choisir une note')),
      );
      return;
    }

    widget.callback(Content(
      name: name.trim(),
      type: selectedType,
      time: DateTime.now().millisecondsSinceEpoch,
      rating: rating,
      status: selectedStatus,
      comments: comments.trim().isEmpty ? null : comments.trim(),
      imageUrl: selectedType == ContentType.movie ? imageUrl : null,
    ));

    if (mounted) context.pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add content')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: ContentType.values
                  .map(
                    (type) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectedType == type
                                ? context.colorScheme.primary
                                : null,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.white,
                              width: selectedType == type ? 2 : 0,
                            ),
                          ),
                          child: InkWell(
                            onTap: () => setState(() {
                              selectedType = type;
                              if (type != ContentType.movie) imageUrl = null;
                            }),
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Icon(type.icon),
                                  Text(type.name),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 24),
            TextField(
              onChanged: (value) => setState(() {
                name = value;
                if (selectedType != ContentType.movie) imageUrl = null;
              }),
              decoration: const InputDecoration(hintText: 'Nom'),
            ),
            if (selectedType == ContentType.movie) ...[
              const SizedBox(height: 16),
              MoviePosterPreview(
                movieName: name,
                onPosterUrlChanged: (url) => imageUrl = url,
              ),
            ],
            const SizedBox(height: 16),
            Center(
              child: StarRating(
                rating: rating,
                onRatingChanged: (value) => setState(() => rating = value),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: ContentStatus.values
                  .map(
                    (status) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectedStatus == status
                                ? context.colorScheme.primary
                                : null,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.white,
                              width: selectedStatus == status ? 2 : 0,
                            ),
                          ),
                          child: InkWell(
                            onTap: () =>
                                setState(() => selectedStatus = status),
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                status.label,
                                textAlign: TextAlign.center,
                                style: AppTheme.textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: (value) => setState(() => comments = value),
              decoration: const InputDecoration(hintText: 'Commentaires'),
              maxLines: 3,
            ),
            const Spacer(),
            CupertinoButton.filled(
              onPressed: _save,
              child: Text(
                'Ajouter',
                style: AppTheme.textTheme.bodyMedium,
              ),
            ),
             const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
