import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../resources/app_colors.dart';
import '../../../utils/theme/input_decoration_theme.dart';

class SearchForm extends StatelessWidget {
  const SearchForm({
    super.key,
    this.formKey,
    this.isEnabled = true,
    this.onSaved,
    this.validator,
    this.onChanged,
    this.onTabFilter,
    this.onFieldSubmitted,
    this.focusNode,
    this.controller,
    this.autofocus = false,
    this.isFilterAvailable = false,
    this.hintText = "Find something...",
  });

  final GlobalKey<FormState>? formKey;
  final bool isEnabled;
  final ValueChanged<String?>? onSaved, onChanged, onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onTabFilter;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final bool autofocus;
  final bool isFilterAvailable;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        autofocus: autofocus,
        controller: controller,
        focusNode: focusNode,
        enabled: isEnabled,
        onChanged: onChanged,
        onSaved: onSaved,
        onFieldSubmitted: onFieldSubmitted,
        validator: validator,
        textInputAction: TextInputAction.done,
        cursorColor: AppColors.primaryAppColor,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          hintText: hintText,
          filled: false,
          border: secondaryOutlineInputBorder(context),
          enabledBorder: secondaryOutlineInputBorder(context),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SvgPicture.asset(
              "assets/icons/Search.svg",
              height: 24,
              color: Theme.of(context).iconTheme.color!.withOpacity(0.3),
            ),
          ),
          suffixIcon: (!isFilterAvailable) ?
          SizedBox(
            width: 40,
            child: Row(
              children: [
                const SizedBox(
                  height: 24,
                  child: VerticalDivider(width: 1),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: onTabFilter,
                    icon: SvgPicture.asset(
                      "assets/icons/Filter.svg",
                      height: 24,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ),
              ],
            ),
          ) : const SizedBox(),
        ),
      ),
    );
  }
}