import 'package:flutter/material.dart';

import '../../../core/constans/imageasset.dart';

class Logo extends StatelessWidget {

  const Logo({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
   
    Image.asset
    (ImageAsset.logo,
    height: 200,
    width: 200,
    );
  }
}
