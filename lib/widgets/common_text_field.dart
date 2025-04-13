import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsarticle/constants/colors.dart';
import 'package:newsarticle/constants/font_size.dart';
import 'package:newsarticle/constants/styles.dart';
import 'package:searchfield/searchfield.dart';

class CommonTextField extends StatefulWidget {
  final String textFieldTitle;
  final String hintText;
  final TextEditingController controller;
  final bool autoValidateMode;
  final Function(String)? validator;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final double bottomSpace;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final Function? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool isEmail;
  final bool isNumberPad;
  final bool isDecimalPad;
  final bool isTextOnly;
  final bool isAlphaNumeric;
  final int maxLength;
  final bool isReadOnly;
  final bool isSearchField;
  final List<String>? suggestions;
  final double borderRadius;
  final Color focusBorderColor;
  final Color borderColor;
  final Color enabledBorderColor;
  final Function(SearchFieldListItem<String>)? onSuggestionTap;
  final bool onlyErrorBorder;
  final BoxConstraints? prefixIconConstraints;
  final bool? isMandatory;
  final bool isVerificationText;
  final Function(String)? onSelected;
  final String? errorText;
  final String? counterText;
  final bool isSearchingIcon;
  final Function? suffixIconOnTap;
  final bool removeDuplicate;
  final int viewPortCount;
  final int? maxLine;

  const CommonTextField(
      {super.key,
      required this.textFieldTitle,
      required this.controller,
      required this.hintText,
      required this.onChanged,
      required this.onSubmitted,
      required this.focusNode,
      required this.bottomSpace,
      this.textInputAction = TextInputAction.next,
      this.prefixIcon,
      this.suffixIcon,
      this.validator,
      this.obscureText = false,
      this.isDecimalPad = false,
      this.isNumberPad = false,
      this.autoValidateMode = true,
      this.isTextOnly = false,
      this.isAlphaNumeric = false,
      this.maxLength = 50,
      this.isReadOnly = false,
      this.isSearchField = false,
      this.isEmail = false,
      this.suggestions,
      this.onSuggestionTap,
      this.onTap,
      this.borderRadius = 5.0,
      this.focusBorderColor = AppColor.primary,
      this.borderColor = AppColor.borderColor,
      this.enabledBorderColor = AppColor.borderColor,
      this.onlyErrorBorder = false,
      this.prefixIconConstraints,
      this.isMandatory = true,
      this.isVerificationText = false,
      this.onSelected,
      this.errorText,
      this.counterText,
      this.isSearchingIcon = false,
      this.suffixIconOnTap,
      this.removeDuplicate = true,
      this.viewPortCount = 6,
      this.maxLine});

  @override
  State<StatefulWidget> createState() {
    return _CommonTextFieldState();
  }
}

class _CommonTextFieldState extends State<CommonTextField> {
  bool isDropDownOpened = false;

  List<TextInputFormatter> inputFormatList = [
    FilteringTextInputFormatter.deny(RegExp("[ ]{2}")),
    FilteringTextInputFormatter.deny(RegExp("^[\\ ]{0,1}")),
  ];

  @override
  void initState() {
    if (widget.isNumberPad) {
      inputFormatList.add(FilteringTextInputFormatter.digitsOnly);
    }
    if (widget.isDecimalPad) {
      inputFormatList.add(FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")));
      inputFormatList.add(
        FilteringTextInputFormatter.allow(RegExp(r'^(0|[1-9]\d*)(\.\d{0,2})?')),
      );
    }
    if (widget.isAlphaNumeric) {
      inputFormatList
          .add(FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")));
    }
    if (widget.isTextOnly) {
      inputFormatList
          .add(FilteringTextInputFormatter.allow(RegExp("[a-z A-Z ]")));
    }

    if (widget.isEmail) {
      inputFormatList
          .add(FilteringTextInputFormatter.allow(RegExp("^[a-zA-Z0-9!@._-]+")));
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    widget.focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        width: constraints.maxWidth > 600 ? 325.w : double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: widget.textFieldTitle.isNotEmpty
                      ? Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text: widget.textFieldTitle,
                                  style: AppTextStyle.medium),
                              TextSpan(
                                text: widget.validator != null &&
                                        widget.isMandatory == true
                                    ? " *"
                                    : "",
                                style: AppTextStyle.medium
                                    .copyWith(color: AppColor.error),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ),
              ],
            ),
            widget.textFieldTitle.isNotEmpty
                ? SizedBox(
                    height: 3.h,
                  )
                : Container(),
            !widget.isSearchField
                ? TextFormField(
                    showCursor: true,
                    contextMenuBuilder: null,
                    key: ValueKey(widget.textFieldTitle),
                    controller: widget.controller,
                    keyboardType: widget.isEmail
                        ? TextInputType.emailAddress
                        : widget.isNumberPad || widget.isDecimalPad
                            ? TextInputType.number
                            : TextInputType.text,
                    obscureText: widget.obscureText,
                    maxLength: widget.maxLength,
                    readOnly: widget.isReadOnly,
                    focusNode: widget.focusNode,
                    style: AppTextStyle.bodyRegular,
                    cursorColor: Colors.black,
                    inputFormatters: inputFormatList,
                    textInputAction: widget.textInputAction,
                    textCapitalization: widget.isEmail
                        ? TextCapitalization.none
                        : TextCapitalization.words,
                    obscuringCharacter: "*",
                    autocorrect: widget.isEmail,
                    maxLines: widget.maxLine ?? 3,
                    autovalidateMode: widget.autoValidateMode
                        ? AutovalidateMode.onUserInteraction
                        : AutovalidateMode.disabled,
                    onTap: () {
                      if (widget.onTap != null) {
                        widget.onTap!();
                      }
                    },
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      fillColor: AppColor.white,
                      filled: true,
                      hintStyle: AppTextStyle.hintTextStyle,
                      prefixIcon: widget.prefixIcon,
                      suffixIcon: widget.suffixIcon != null
                          ? IconButton(
                              iconSize: 16.sp,
                              onPressed: () {
                                widget.suffixIconOnTap?.call();
                                widget.onTap?.call();
                              },
                              icon: widget.suffixIcon!)
                          : null,
                      isDense: true,
                      contentPadding:
                          const EdgeInsets.only(top: 11, bottom: 11, left: 11),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius),
                          borderSide: BorderSide(
                              color: widget.borderColor, width: 1.0)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius),
                        borderSide: BorderSide(
                            color: widget.focusBorderColor, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius),
                          borderSide:
                              BorderSide(color: widget.enabledBorderColor)),
                      errorBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius),
                          borderSide: const BorderSide(
                              color: AppColor.error, width: 1.0)),
                      counterText: (widget.onlyErrorBorder ||
                              widget.controller.text.isEmpty)
                          ? widget.counterText ?? ""
                          : "",
                      counterStyle: const TextStyle(color: AppColor.error),
                      errorText: widget.errorText,
                      errorStyle: AppTextStyle.regular.copyWith(
                          fontSize:
                              widget.onlyErrorBorder ? 0 : AppFontSize.dp12,
                          color: AppColor.error),
                      prefixIconConstraints: widget.prefixIconConstraints,
                      errorMaxLines: 2,
                    ),
                    validator: widget.validator != null
                        ? (val) => widget.validator!.call(val!)
                        : null,
                    onChanged: (val) {
                      widget.onChanged.call(val);
                    },
                    onFieldSubmitted: (val) => widget.onSubmitted.call(val),
                    //enableInteractiveSelection: !widget.isClipPaste,
                  )
                : SearchField(
                    key: ValueKey(widget.textFieldTitle),
                    hint: widget.hintText,
                    controller: widget.controller,
                    readOnly: widget.isReadOnly,
                    focusNode: widget.focusNode,
                    enabled: true,
                    autovalidateMode: widget.autoValidateMode
                        ? AutovalidateMode.onUserInteraction
                        : AutovalidateMode.disabled,
                    onTap: () {
                      if (widget.onTap != null) {
                        widget.onTap!();
                      }
                    },
                    suggestionsDecoration: SuggestionDecoration(
                        color: AppColor.white,
                        hoverColor: AppColor.primary,
                        selectionColor: AppColor.primary),
                    suggestions: widget.removeDuplicate
                        ? widget.suggestions!
                            .toSet()
                            .toList()
                            .map((e) => SearchFieldListItem<String>(e,
                                child: Text(
                                  e,
                                  style: AppTextStyle.bodyRegular,
                                  maxLines: 3,
                                  textAlign: TextAlign.start,
                                  softWrap: true,
                                )))
                            .toList()
                        : widget.suggestions!
                            .map((e) => SearchFieldListItem<String>(e,
                                child: Text(
                                  e,
                                  style: AppTextStyle.bodyRegular,
                                  maxLines: 3,
                                  textAlign: TextAlign.start,
                                  softWrap: true,
                                )))
                            .toList(),
                    onSearchTextChanged: (val) {
                      widget.onChanged(val);
                      return;
                    },
                    maxSuggestionsInViewPort: widget.viewPortCount,
                    itemHeight: 55.h,
                    suggestionState: Suggestion.expand,
                    inputFormatters: inputFormatList,
                    suggestionAction: SuggestionAction.next,
                    onSubmit: (val) => widget.onSubmitted.call(val),
                    suggestionStyle: AppTextStyle.bodyRegular,
                    onSuggestionTap: (SearchFieldListItem<String> val) {
                      widget.controller.text = val.searchKey;
                      widget.onSuggestionTap?.call(val);
                      isDropDownOpened = !isDropDownOpened;

                      widget.focusNode.unfocus();
                    },
                    onTapOutside: (val) {
                      widget.focusNode.unfocus();
                    },
                    searchInputDecoration: SearchInputDecoration(
                        hintStyle: AppTextStyle.hintTextStyle,
                        searchStyle: AppTextStyle.bodyRegular,
                        hintText: widget.hintText,
                        suffixIcon: widget.suffixIcon != null
                            ? GestureDetector(
                                onTap: () {
                                  isDropDownOpened = !isDropDownOpened;
                                  isDropDownOpened
                                      ? widget.focusNode.requestFocus()
                                      : widget.focusNode.unfocus();
                                  if (widget.suffixIconOnTap != null) {
                                    widget.suffixIconOnTap!.call();
                                  }

                                  widget.onTap?.call();
                                },
                                child: widget.isSearchingIcon
                                    ? const Icon(Icons.search)
                                    : const Icon(
                                        Icons.keyboard_arrow_down_rounded),
                              )
                            : null,
                        isDense: true,
                        fillColor: AppColor.white,
                        filled: true,
                        contentPadding: const EdgeInsets.only(
                            top: 11, bottom: 11, left: 11),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(widget.borderRadius),
                            borderSide: BorderSide(
                                color: widget.borderColor, width: 1.0)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius),
                          borderSide: BorderSide(
                              color: widget.focusBorderColor, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(widget.borderRadius),
                            borderSide:
                                BorderSide(color: widget.enabledBorderColor)),
                        errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(widget.borderRadius),
                            borderSide: const BorderSide(
                                color: AppColor.error, width: 1.0)),
                        counterText: "",
                        errorMaxLines: 2),
                    suggestionDirection: SuggestionDirection.flex,
                    validator: widget.validator != null
                        ? (val) => widget.validator!.call(val!)
                        : null,
                  ),
            SizedBox(
              height: widget.bottomSpace,
            )
          ],
        ),
      );
    });
  }
}
