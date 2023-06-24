import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Settings/BrandInfo/View/SFStorePhoto.dart';
import 'package:sandfriends_web/SharedComponents/View/SFAvatar.dart';
import 'package:sandfriends_web/SharedComponents/View/SFButton.dart';
import 'package:sandfriends_web/SharedComponents/View/SFTextfield.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import '../../../../SharedComponents/View/SFDivider.dart';
import '../../ViewModel/SettingsViewModel.dart';

class BrandInfo extends StatefulWidget {
  SettingsViewModel viewModel;

  BrandInfo({super.key, required this.viewModel});

  @override
  State<BrandInfo> createState() => _BrandInfoState();
}

class _BrandInfoState extends State<BrandInfo> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Logo do seu estabelecimento",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        if (widget.viewModel.isEmployeeAdmin)
                          Row(children: [
                            Expanded(
                              child: SFButton(
                                buttonLabel: "Escolher arquivo",
                                buttonType: ButtonType.Secondary,
                                onTap: () {
                                  widget.viewModel.setStoreAvatar(context);
                                },
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                          ]),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SFAvatar(
                        height: 160,
                        image: widget.viewModel.storeEdit.logo,
                        editImage: widget.viewModel.storeAvatar,
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: defaultPadding),
                child: SFDivider(),
              ),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Descrição",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "(Todos os jogadores que entrarem na sua página, verão essa descrição. Seja criativo!)",
                              style: TextStyle(
                                color: textDarkGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SFTextField(
                              labelText: "",
                              pourpose: TextFieldPourpose.Multiline,
                              controller:
                                  widget.viewModel.descriptionController,
                              validator: (a) {
                                return null;
                              },
                              minLines: 5,
                              maxLines: 5,
                              hintText:
                                  "Fale sobre seu estabelecimento, infraestrutura, estacionamento...",
                              onChanged: (newValue) => widget.viewModel
                                  .onChangedDescription(newValue),
                              enable: widget.viewModel.isEmployeeAdmin,
                            ),
                            Text(
                              "${widget.viewModel.descriptionLength}/255",
                              style: const TextStyle(color: textDarkGrey),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Instagram",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "(Link para sua página)",
                              style: TextStyle(
                                color: textDarkGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Expanded(
                              child: SFTextField(
                                controller:
                                    widget.viewModel.instagramController,
                                labelText: "",
                                pourpose: TextFieldPourpose.Standard,
                                validator: (value) {
                                  return null;
                                },
                                onChanged: (newValue) => widget.viewModel
                                    .onChangedInstagram(newValue),
                                enable: widget.viewModel.isEmployeeAdmin,
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: defaultPadding),
                child: SFDivider(),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Fotos da sua quadra",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          "(mín. 2)",
                          style: TextStyle(color: textDarkGrey),
                        ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        if (widget.viewModel.isEmployeeAdmin)
                          Row(children: [
                            Expanded(
                              child: SFButton(
                                buttonLabel: "Adicionar foto",
                                buttonType: ButtonType.Secondary,
                                onTap: () {
                                  widget.viewModel.addStorePhoto(context);
                                },
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                          ]),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: widget.viewModel.storeEdit.photos.isEmpty
                        ? Container()
                        : SizedBox(
                            height: 230,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  widget.viewModel.storeEdit.photos.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return StorePhotoCard(
                                  storePhoto:
                                      widget.viewModel.storeEdit.photos[index],
                                  delete: () {
                                    widget.viewModel.deleteStorePhoto(
                                      widget.viewModel.storeEdit.photos[index]
                                          .idStorePhoto,
                                    );
                                  },
                                  isAdmin: widget.viewModel.isEmployeeAdmin,
                                );
                              },
                            ),
                          ),
                  ),
                ],
              ),
              const SizedBox(
                height: 2 * defaultPadding,
              )
            ],
          ),
        ),
      ],
    );
  }
}
