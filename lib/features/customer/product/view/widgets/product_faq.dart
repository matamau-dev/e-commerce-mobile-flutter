import 'package:flutter/material.dart';

class QuestionItem {
  String question;
  String answer;
  bool isExpanded;
  QuestionItem(this.question, this.answer, [this.isExpanded = false]);
}

Future<List<QuestionItem>> getQuestions() async {
  await Future.delayed(const Duration(seconds: 1));
  return [
    QuestionItem('¿Es compatible con Flutter?', 'Sí, totalmente compatible.'),
    QuestionItem('¿Tiene garantía?', 'Ofrecemos 1 año de garantía.'),
  ];
}

class ProductFAQ extends StatefulWidget {
  const ProductFAQ({super.key});

  @override
  State<ProductFAQ> createState() => _ProductFAQState();
}

class _ProductFAQState extends State<ProductFAQ> {
  List<QuestionItem> _questions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final data = await getQuestions();
    if (mounted) {
      setState(() {
        _questions = data;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Preguntas Frecuentes",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        const SizedBox(height: 12),
        _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ExpansionPanelList(
                elevation: 0,
                expandedHeaderPadding: EdgeInsets.zero,
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    _questions[index].isExpanded =
                        !_questions[index].isExpanded;
                  });
                },
                children: _questions.map<ExpansionPanel>((QuestionItem item) {
                  return ExpansionPanel(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    canTapOnHeader: true,
                    headerBuilder: (context, isExpanded) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          item.question,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      );
                    },
                    body: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        item.answer,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                    isExpanded: item.isExpanded,
                  );
                }).toList(),
              ),
      ],
    );
  }
}
