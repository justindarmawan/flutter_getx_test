import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../themes/colors.dart';
import '../widgets/shimmering_image.dart';

class CustomDialog extends StatelessWidget {
  final String imageUrl, buttonText;
  final bool loading;
  final onPressed;

  CustomDialog({
    @required this.imageUrl,
    @required this.buttonText,
    @required this.loading,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: new BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ],
              border: Border.all(
                color: yellow,
                width: 5.0,
              ),
            ),
            child: Container(
              width: 300,
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // mainAxisSize: MainAxisSize.min, // To make the card compact
                children: <Widget>[
                  loading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Stack(
                                  children: [
                                    ShimmeringImage(240, 240),
                                    FadeInImage.memoryNetwork(
                                      placeholder: kTransparentImage,
                                      image: imageUrl,
                                      width: 240,
                                      height: 240,
                                      fit: BoxFit.contain,
                                      alignment: Alignment.center,
                                    ),
                                  ],
                                )),
                            SizedBox(height: 8.0),
                            Align(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                onPressed: onPressed,
                                child: Text(
                                  buttonText,
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
