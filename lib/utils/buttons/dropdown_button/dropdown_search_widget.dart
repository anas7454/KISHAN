import 'package:constructo_worker/utils/common/debug_utils.dart';
import 'package:constructo_worker/utils/theme/sizes/container_const_funtions.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'dropdown_model.dart';

class DropDownSearchFieldCustom extends StatefulWidget {
  // final ValueChanged<String?>? onSuggestions;
  final Future<List<DropdownModel>> Function(String)? onSuggestions;
  final ValueChanged<DropdownModel?>? onSuggestionSelected;
  final DropdownModel dropdownValue;
  // final List<DropdownModel> dropdownList;
  final String? validatorText;
  final String? title;
  final String? hint;
  final Color? fillColor;
  final bool isSmall;
  final TextEditingController textEditingController;

  const DropDownSearchFieldCustom({
    super.key,
    required this.onSuggestionSelected,
    required this.onSuggestions,
    required this.textEditingController,
    required this.dropdownValue,
    // required this.dropdownList,
    this.isSmall = false,
    this.validatorText,
    this.title,
    this.hint,
    this.fillColor,
  });

  @override
  State<DropDownSearchFieldCustom> createState() =>
      _DropDownSearchFieldCustomState();
}

class _DropDownSearchFieldCustomState extends State<DropDownSearchFieldCustom> {
  bool _showClear = false;
  late VoidCallback _controllerListener;

  String _lastQuery = "";
  List<DropdownModel> _cachedList = [];

  @override
  void initState() {
    super.initState();

    // Initial text
    widget.textEditingController.text = widget.dropdownValue.name ?? "";

    // Listener define
    _controllerListener = () {
      if (!mounted) return; // ✅ widget disposed check
      setState(() {
        _showClear = widget.textEditingController.text.isNotEmpty;
      });
    };

    widget.textEditingController.addListener(_controllerListener);
  }

  @override
  void didUpdateWidget(covariant DropDownSearchFieldCustom oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.dropdownValue != widget.dropdownValue) {
      widget.textEditingController.text = widget.dropdownValue.name ?? "";
    }
  }

  @override
  void dispose() {
    widget.textEditingController.removeListener(
      _controllerListener,
    ); // ✅ remove listener
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // printDebugCustom("dropdown list length come-->${widget.dropdownList.length}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // if (widget.title != null)
        //   Text(
        //     widget.title!,
        //     style: AppTextStyles.ts15color131313fw400().copyWith(fontSize: widget.isSmall ? 14.sp : null),
        //   ),
        // sizedboxHeight(5),
        FormField<List<DropdownModel>>(
          validator: dropdownValidator,
          initialValue: (widget.dropdownValue.value?.isNotEmpty ?? false)
              ? [widget.dropdownValue]
              : [],
          builder: (fieldState) {
            return DropDownSearchField<DropdownModel>(
              // key: ,
              isMultiSelectDropdown: false,
              displayAllSuggestionWhenTap: false,
              validator: (_) => null,

              textFieldConfiguration: TextFieldConfiguration(
                controller: widget.textEditingController,
                style: AppTextStyles.ts10w500colorBlack(),
                decoration: InputDecoration(
                  errorText: fieldState.errorText,
                  hintText: widget.hint ?? "Destination..",
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: widget.isSmall ? 8.w : 10.rw,
                    vertical: 10.rh,
                  ),
                  enabledBorder: borderInputDefault(),
                  border: borderInputDefault(),
                  focusedBorder: borderInputDefault(),
                  errorBorder: borderInputDefault(color: Colors.red),
                  focusedErrorBorder: borderInputDefault(color: Colors.red),
                  fillColor: widget.fillColor,
                  filled: widget.fillColor != null,
                  prefixIcon: Container(
                    padding: const EdgeInsets.only(left: 5),
                    child: const Center(child: Icon(Icons.search_rounded)),
                  ),
                  prefixIconConstraints: const BoxConstraints(maxWidth: 35),
                  suffixIcon: _showClear
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 20),
                          onPressed: () {
                            widget.textEditingController.clear();
                            widget.onSuggestionSelected?.call(null);
                            fieldState.didChange([]);
                            if (mounted) {
                              setState(() {
                                _showClear = false;
                              });
                            }
                          },
                        )
                      : null,
                ),
              ),

              suggestionsCallback: (String pattern) {
                final query = pattern.trim();

                /// 1️⃣ focus / empty → no future → no loader
                if (query.isEmpty && _cachedList.isEmpty) {
                  return _cachedList; // 👈 sync return
                }

                /// 2️⃣ same text → reuse cache
                if (query == _lastQuery && _cachedList.isNotEmpty) {
                  return _cachedList; // 👈 sync return
                }

                /// 3️⃣ API call (Future only here)
                _lastQuery = query;

                return widget.onSuggestions!(query).then((list) {
                  /// ⭐ EXACT place
                  if (!mounted) return <DropdownModel>[];

                  _cachedList = list;
                  return list;
                });
              },
              itemBuilder: (context, DropdownModel suggestion) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.rw,
                        vertical: 10.rh,
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 5.rw),
                            child: Center(
                              child: Icon(Icons.search_rounded, size: 18.rh),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              suggestion.name ?? "",
                              style: AppTextStyles.ts10w500colorBlack(),
                            ),
                          ),

                          // Spacer(),
                          Container(
                            margin: EdgeInsets.only(left: 5.rw),
                            child: Center(
                              child: Icon(
                                Icons.arrow_outward_rounded,
                                size: 18.rh,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    dividerEEEEEE(),
                  ],
                );

                //  ListTile(
                //   title: Text(suggestion.name ?? "", style: AppTextStyles.ts10w500colorBlack()),
                //   subtitle: suggestion.subtitle == null || suggestion.subtitle == ""
                //       ? null
                //       : Text(suggestion.subtitle ?? "", style: AppTextStyles.ts10w500colorBlack()),
                //   dense: true,
                //   contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
                // );
              },
              onSuggestionSelected: (DropdownModel suggestion) {
                widget.textEditingController.text = suggestion.name ?? "";
                widget.onSuggestionSelected?.call(suggestion);
                fieldState.didChange([suggestion]);
              },
              noItemsFoundBuilder: (context) {
                return Container(height: 0);
              },
              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: borderRadiusDefault(8.rr),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

String? dropdownValidator(List<DropdownModel>? value) {
  printDebugCustom("run dropdownValidator work value->$value");
  if (value == null || value.isEmpty) {
    return "Please select a destination";
  }
  return null;
}
