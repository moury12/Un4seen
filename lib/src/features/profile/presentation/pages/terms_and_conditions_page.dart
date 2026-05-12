import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/core_export.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: true,
              title: Text(
                AppStaticStrings.termsAndConditions.tr,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            SliverPadding(
              padding: AppPadding.getPadding12(context),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const CustomText(
                    'Terms & Condition',
                    variant: TextVariant.headlineSmall,
                    fontWeight: FontWeight.bold,
                  ),
                  space12H,
                  const CustomText(
                    'gravida elit enim, lobortis, ex orci lobortis, Donec orci elit felis, luctus ultrices odio tincidunt cursus elit ex nisi vehicula, Morbi Nunc Morbi venenatis sollicitudin, tortor, dui non quam dui, nibh tortor, elit viverra maximus ipsum\n\nmassa tincidunt massa non, Ut ex lobortis, nulla, sit orci Nam massa viverra venenatis massa placerat in viverra laoreet massa Lorem at elit scelerisque Quisque viverra id ipsum risus quam Lorem id quis ultrices vel placerat dui. elit nec\n\nlobortis, vehicula, tempor Quisque sed felis, vitae Sed varius dolor volutpat in sed non, massa sit porta nisi ex, porta nulla, turpis efficitur. Nunc dolor dolor id non est, lacus, varius ipsum placerat, elementum dignissim, Vestibulum\n\nquam efficitur, gravida non, lacus, vehicula, nec id commodo turpis Donec Nam faucibus quis elementum tincidunt tortor, orci adipiscing odio sed sollicitudin, eget quis faucibus diam Cras fringilla Nam Lorem adipiscing vel in Vestibulum',
                    variant: TextVariant.bodyMedium,
                    color: AppColors.kSecondaryTextColor,
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
