import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udsaholoan/core.dart';

class CustomCardProfile extends StatelessWidget {
  final String nama;
  final String noTelp;
  final String profilePicture;
  final dynamic onTap;
  const CustomCardProfile({
    super.key,
    required this.nama,
    required this.noTelp,
    required this.profilePicture,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 28.0,
                ),
                padding: const EdgeInsets.all(12.0),
                decoration: const BoxDecoration(
                  color: basicColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      8.0,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      nama.capitalize!,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.phone,
                          size: 12.0,
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          noTelp,
                          style: const TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: profilePicture != ''
                    ? CircleAvatar(
                        radius: 26.0,
                        backgroundImage: NetworkImage(profilePicture),
                      )
                    : const CircleAvatar(
                        radius: 26.0,
                        backgroundColor: darkBlueColor,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: onTap,
                  child: const Icon(
                    Icons.edit,
                    size: 24.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
