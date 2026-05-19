import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appColors.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appStrings.dart';
import 'package:onesoff/app/core/utils/deviceUtility/deviceResponsive.dart';


class ShopOwnerTab extends StatefulWidget {
  const ShopOwnerTab({super.key});

  @override
  State<ShopOwnerTab> createState() => _ShopOwnerTabState();
}

class _ShopOwnerTabState extends State<ShopOwnerTab> {
  bool _dialogShown = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showWelcomeDialog());
  }

  Future<void> _showWelcomeDialog() async {
    if (_dialogShown || !mounted) return;
    _dialogShown = true;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) => const _VendorWelcomeDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.shopOwnerDashboardTitle)),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: DeviceResponsive.w(context, 24)),
          child: Text(
            AppStrings.shopOwnerDashboardDescription,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: DeviceResponsive.sp(context, 16),
              height: 1.3,
            ),
          ),
        ),
      ),
    );
  }
}

class _VendorWelcomeDialog extends StatefulWidget {
  const _VendorWelcomeDialog();

  @override
  State<_VendorWelcomeDialog> createState() => _VendorWelcomeDialogState();
}

class _VendorWelcomeDialogState extends State<_VendorWelcomeDialog> {
  late final ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 4));
    _confettiController.play();

    Future<void>.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double topOffset = DeviceResponsive.h(context, 30);
    final double cardRadius = DeviceResponsive.r(context, 16);
    final double horizontalPadding = DeviceResponsive.w(context, 20);
    final double verticalPaddingTop = DeviceResponsive.h(context, 36);
    final double verticalPaddingBottom = DeviceResponsive.h(context, 24);

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: topOffset),
            padding: EdgeInsets.fromLTRB(
              horizontalPadding,
              verticalPaddingTop,
              horizontalPadding,
              verticalPaddingBottom,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(cardRadius),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  AppStrings.welcomeVendorTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: DeviceResponsive.sp(context, 24, minScale: 0.92, maxScale: 1.2),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: DeviceResponsive.h(context, 10)),
                Text(
                  AppStrings.welcomeVendorDescription,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: DeviceResponsive.sp(context, 16, minScale: 0.92, maxScale: 1.12),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            emissionFrequency: 0.06,
            numberOfParticles: 20,
            gravity: 0.28,
            colors: const <Color>[
              Color(0xFF6A2236),
              Color(0xFFD39A2C),
              Color(0xFF5A9A6F),
              Color(0xFF7090D1),
              Color(0xFFE88B8B),
            ],
          ),
        ],
      ),
    );
  }
}
