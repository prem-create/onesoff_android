import 'package:flutter/material.dart';

import '../utils/deviceConstants/appColors.dart';
import '../utils/deviceUtility/deviceResponsive.dart';

class SearchableMultiSelectBottomSheet {
  SearchableMultiSelectBottomSheet._();
  static bool _isOpen = false;

  static Future<List<String>?> show({
    required BuildContext context,
    required String title,
    required List<String> options,
    required List<String> initialValues,
    String searchHint = 'Search',
  }) async {
    if (_isOpen) return initialValues;
    _isOpen = true;

    final Set<String> selectedValues = initialValues.toSet();
    String query = '';

    try {
      final List<String>? result = await showModalBottomSheet<List<String>>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setSheetState) {
              final List<String> filtered = options
                  .where((String item) => item.toLowerCase().contains(query.toLowerCase()))
                  .toList(growable: false);

              return SafeArea(
                top: false,
                child: Container(
                  height: MediaQuery.sizeOf(context).height * 0.82,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF7F7F8),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: DeviceResponsive.h(context, 10)),
                        width: DeviceResponsive.w(context, 48),
                        height: DeviceResponsive.h(context, 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD0D0D4),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                title,
                                style: TextStyle(
                                  fontSize: DeviceResponsive.sp(context, 18, minScale: 0.92, maxScale: 1.14),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                selectedValues.clear();
                                setSheetState(() {});
                              },
                              child: const Text('Clear'),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                        child: TextField(
                          onChanged: (String value) {
                            setSheetState(() {
                              query = value.trim();
                            });
                          },
                          decoration: InputDecoration(
                            hintText: searchHint,
                            prefixIcon: const Icon(Icons.search),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: filtered.isEmpty
                            ? Center(
                                child: Text(
                                  'No results found',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: DeviceResponsive.sp(context, 14, minScale: 0.92, maxScale: 1.1),
                                  ),
                                ),
                              )
                            : ListView.separated(
                                itemCount: filtered.length,
                                separatorBuilder: (_, __) => Divider(height: DeviceResponsive.h(context, 1)),
                                itemBuilder: (BuildContext context, int index) {
                                  final String value = filtered[index];
                                  final bool checked = selectedValues.contains(value);
                                  return CheckboxListTile(
                                    value: checked,
                                    onChanged: (bool? isChecked) {
                                      setSheetState(() {
                                        if (isChecked ?? false) {
                                          selectedValues.add(value);
                                        } else {
                                          selectedValues.remove(value);
                                        }
                                      });
                                    },
                                    title: Text(
                                      value,
                                      style: TextStyle(
                                        fontSize: DeviceResponsive.sp(context, 15, minScale: 0.92, maxScale: 1.1),
                                      ),
                                    ),
                                    activeColor: AppColors.primary,
                                    controlAffinity: ListTileControlAffinity.leading,
                                  );
                                },
                              ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          16,
                          10,
                          16,
                          MediaQuery.viewPaddingOf(context).bottom + 12,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(
                                selectedValues.toList(growable: false),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: const Text(
                              'Apply Selection',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );

      return result;
    } finally {
      _isOpen = false;
    }
  }
}
