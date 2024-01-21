import 'package:flutter/material.dart';
import 'package:learn_apps/widgets/get_json.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.langName,
    required this.image,
    required this.description,
  });

  final String langName;
  final String image;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 30.0,
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            // in changelog 1 we will pass the langname name to ther other widget class
            // this name will be used to open a particular JSON file
            // for a particular language
            builder: (context) => GetJson(langName),
          ));
        },
        child: Material(
          color: Colors.indigoAccent,
          elevation: 10.0,
          borderRadius: BorderRadius.circular(25.0),
          child: Column(
            children: <Widget>[
              _buildImage(),
              _buildTitle(),
              _buildDescription(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(100.0),
                child: SizedBox(
                  // changing from 200 to 150 as to look better
                  height: 150.0,
                  width: 150.0,
                  child: ClipOval(
                    child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        image,
                      ),
                    ),
                  ),
                ),
              ),
            );
  }

  Widget _buildDescription() {
    return Container(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                description,
                style: const TextStyle(
                    fontSize: 18.0, color: Colors.white, fontFamily: "Alike"),
                maxLines: 5,
                textAlign: TextAlign.justify,
              ),
            );
  }

  Widget _buildTitle() {
    return Center(
              child: Text(
                langName,
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontFamily: "Quando",
                  fontWeight: FontWeight.w700,
                ),
              ),
            );
  }


}
