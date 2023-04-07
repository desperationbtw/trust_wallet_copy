import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:trust_wallet_scm/domain/enum/import_options.dart';
import 'package:trust_wallet_scm/domain/models/import_variant.dart';
import 'package:trust_wallet_scm/uikit/uikit.dart';

class VariantScreen extends StatefulWidget {
  final ImportVariant variant;
  final bool hasTabs;

  const VariantScreen({
    super.key,
    required this.variant,
    this.hasTabs = true,
  });

  @override
  State<VariantScreen> createState() => _VariantScreenState();
}

class _VariantScreenState extends State<VariantScreen> with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: widget.variant.options.length, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = UITheme.of(context);

    return Scaffold(
      appBar: UIAppBar(
        title: 'Импортировать ${widget.variant.name}',
        actions: const [
          Icon(UIIcons.ic_wallet_scan),
          SizedBox(width: 16.0),
        ],
      ),
      body: Column(
        children: [
          if (widget.hasTabs)
          TabBar(
            labelColor: theme.accent,
            unselectedLabelColor: const Color.fromARGB(255, 101, 114, 131),
            dividerColor: Colors.transparent,
            controller: _controller,
            tabs: [
              if (widget.variant.options.contains(ImportOptions.phrase)) Tab(text: ImportOptions.phrase.text),
              if (widget.variant.options.contains(ImportOptions.keystore)) Tab(text: ImportOptions.keystore.text),
              if (widget.variant.options.contains(ImportOptions.privateKey)) Tab(text: ImportOptions.privateKey.text),
              if (widget.variant.options.contains(ImportOptions.address)) Tab(text: ImportOptions.address.text),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: [
                if (widget.variant.options.contains(ImportOptions.phrase)) _Phrase(variant: widget.variant),
                if (widget.variant.options.contains(ImportOptions.keystore)) const Text('keystore'),
                if (widget.variant.options.contains(ImportOptions.privateKey)) const Text('privateKey'),
                if (widget.variant.options.contains(ImportOptions.address)) const Text('address'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Phrase extends StatefulWidget {
  final ImportVariant variant;

  const _Phrase({required this.variant});

  @override
  State<_Phrase> createState() => __PhraseState();
}

class __PhraseState extends State<_Phrase> {
  late TextEditingController _nameController;
  late FocusNode _nameFocus;
  late TextEditingController _phraseController;
  late FocusNode _phraseFocus;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'Кошелек 1');
    _nameFocus = FocusNode();
    _phraseController = TextEditingController();
    _phraseFocus = FocusNode();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameFocus.dispose();
    _phraseController.dispose();
    _phraseFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = UITheme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0).copyWith(bottom: 0.0),
              child: TextField(
                onTap: () => setState(() => FocusScope.of(context).requestFocus(_nameFocus)),
                focusNode: _nameFocus,
                controller: _nameController,
                decoration: _decoration(theme, labelText: 'Имя', hasFocus: _nameFocus.hasFocus),
                maxLines: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: TextField(
                      onTap: () => setState(() => FocusScope.of(context).requestFocus(_phraseFocus)),
                      focusNode: _phraseFocus,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.top,
                      controller: _phraseController,
                      decoration: _decoration(theme, hint: 'Фраза', labelText: 'Фраза', canPaste: true, hasFocus: _phraseFocus.hasFocus),
                      minLines: 3,
                      maxLines: null,
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: InkWell(
                        onTap: () async {
                          final clipboard = await Clipboard.getData(Clipboard.kTextPlain);
                          if (clipboard != null && clipboard.text != null) {
                            _phraseController.text = clipboard.text!;
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'ВСТАВИТЬ',
                            style: UITextStyle.custom(theme, fontSize: 14, fontWeight: FontWeight.w500, color: theme.accent),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Обычно 12 (иногда 18, 24) слова разделены одним пробелом',
                style: UITextStyle.custom(theme, color: theme.textBlue, fontSize: 14.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: const Text('Импортировать')),
              ),
            )
          ],
        ),
        TextButton(onPressed: () {}, child: const Text('Что ткое секретная фраза?')),
      ],
    );
  }

  InputDecoration _decoration(UIThemeData theme, {String? labelText, String? hint, bool canPaste = false, bool hasFocus = false}) {
    return InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(16.0, canPaste ? 40.0 : 16.0, 16.0, 16.0),
      labelText: labelText,
      labelStyle: UITextStyle.title(theme),
      hintText: hint,
      alignLabelWithHint: true,
      // helperText: widget.helperText,
      helperStyle: UITextStyle.caption(theme),
      floatingLabelStyle: TextStyle(color: hasFocus ? theme.textBlue : theme.textGray),
      enabledBorder: _border(theme.textGray),
      focusedBorder: _border(theme.textBlue, isFocused: true),
    );
  }

  OutlineInputBorder _border(
    Color color, {
    bool isFocused = false,
  }) =>
      OutlineInputBorder(
        borderSide: BorderSide(color: color, width: isFocused ? 2.0 : 1.0),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      );
}
