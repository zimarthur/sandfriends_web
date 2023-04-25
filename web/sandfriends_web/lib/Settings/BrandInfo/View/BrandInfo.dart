import 'package:flutter/material.dart';
import 'package:sandfriends_web/Settings/BrandInfo/View/SFStorePhoto.dart';
import 'package:sandfriends_web/SharedComponents/View/SFButton.dart';
import 'package:sandfriends_web/SharedComponents/View/SFTextfield.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import '../../../SharedComponents/View/SFDivider.dart';
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
                        Row(children: [
                          Expanded(
                            child: SFButton(
                              buttonLabel: "Escolher arquivo",
                              buttonType: ButtonType.Secondary,
                              onTap: () {
                                widget.viewModel.brandInfoViewModel
                                    .setStoreAvatar(context);
                                widget.viewModel.storeInfoChanged(context);
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
                      child: widget.viewModel.brandInfoViewModel.storeAvatar ==
                              null
                          ? CircleAvatar(
                              radius: 80,
                              child: AspectRatio(
                                aspectRatio: 1 / 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(80),
                                  child: Image.asset(
                                    r"assets/Arthur.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          : Image.memory(
                              widget.viewModel.brandInfoViewModel.storeAvatar!,
                              height: 160,
                              width: 160,
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
                              controller: widget.viewModel.brandInfoViewModel
                                  .descriptionController,
                              validator: (a) {
                                return null;
                              },
                              minLines: 5,
                              maxLines: 5,
                              hintText:
                                  "Fale sobre seu estabelecimento, infraestrutura, estacionamento...",
                              onChanged: (p0) =>
                                  widget.viewModel.storeInfoChanged(context),
                            ),
                            Text(
                              "${widget.viewModel.brandInfoViewModel.descriptionLength}/255",
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
                                controller: widget.viewModel.brandInfoViewModel
                                    .instagramController,
                                labelText: "",
                                pourpose: TextFieldPourpose.Standard,
                                validator: (value) {
                                  return null;
                                },
                                onChanged: (p0) =>
                                    widget.viewModel.storeInfoChanged(context),
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
                        Row(children: [
                          Expanded(
                            child: SFButton(
                              buttonLabel: "Adicionar foto",
                              buttonType: ButtonType.Secondary,
                              onTap: () {
                                widget.viewModel.brandInfoViewModel
                                    .addStorePhoto(context);
                                widget.viewModel.storeInfoChanged(context);
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
                    child:
                        widget.viewModel.brandInfoViewModel.storePhotos.isEmpty
                            ? Container()
                            : SizedBox(
                                height: 220,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: widget.viewModel.brandInfoViewModel
                                      .storePhotos.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return SFStorePhoto(
                                        image: widget
                                            .viewModel
                                            .brandInfoViewModel
                                            .storePhotos[index],
                                        delete: () {
                                          widget.viewModel.brandInfoViewModel
                                              .deleteStorePhoto(context, index);
                                          widget.viewModel
                                              .storeInfoChanged(context);
                                        });
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
