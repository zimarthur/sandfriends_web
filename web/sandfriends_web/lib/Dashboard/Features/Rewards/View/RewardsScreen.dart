import 'package:flutter/material.dart';
import 'package:sandfriends_web/SharedComponents/SFCard.dart';
import 'package:sandfriends_web/SharedComponents/SFTable.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../SharedComponents/SFButton.dart';
import '../../../../SharedComponents/SFHeader.dart';
import '../../../../Utils/Constants.dart';
import '../Model/Reward.dart';
import '../Model/RewardDataSource.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  List<Reward> rewards = <Reward>[];

  late RewardsDataSource rewardsDataSource;

  @override
  void initState() {
    super.initState();
    rewards = getRewards();
    rewardsDataSource = RewardsDataSource(rewards: rewards);
  }

  List<Reward> getRewards() {
    return [
      Reward(
          reward: "Agua", date: "20/02/2023", hour: "09:35", player: "Arthur"),
      Reward(
          reward: "Agua", date: "20/02/2023", hour: "09:35", player: "Arthur"),
      Reward(
          reward: "Agua", date: "20/02/2023", hour: "09:35", player: "Arthur"),
      Reward(
          reward: "Agua", date: "20/02/2023", hour: "09:35", player: "Arthur"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: SFHeader(
                    header: "Recompensas",
                    description:
                        "Confira as recompensas que os jogadores já retiraram no seu estabelecimento!"),
              ),
              SFButton(
                buttonLabel: "Adic. Recompensa",
                buttonType: ButtonType.Primary,
                onTap: () {},
                iconFirst: true,
                iconPath: r"assets/icon/plus.svg",
                textPadding: const EdgeInsets.symmetric(
                  vertical: defaultPadding,
                  horizontal: defaultPadding * 2,
                ),
              )
            ],
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          Row(
            children: [
              SfDataGrid(
                source: rewardsDataSource,
                columns: <GridColumn>[
                  GridColumn(
                      columnName: 'date',
                      label: Container(
                          padding: EdgeInsets.all(16.0),
                          alignment: Alignment.centerRight,
                          child: Text(
                            'date',
                          ))),
                  GridColumn(
                      columnName: 'hour',
                      label: Container(
                          padding: EdgeInsets.all(16.0),
                          alignment: Alignment.centerLeft,
                          child: Text('hour'))),
                  GridColumn(
                      columnName: 'player',
                      width: 120,
                      label: Container(
                          padding: EdgeInsets.all(16.0),
                          alignment: Alignment.centerLeft,
                          child: Text('player'))),
                  GridColumn(
                      columnName: 'reward',
                      label: Container(
                          padding: EdgeInsets.all(16.0),
                          alignment: Alignment.centerRight,
                          child: Text('reward'))),
                ],
              ),
              const SizedBox(
                width: 2 * defaultPadding,
              ),
              SFCard(
                height: 200,
                width: 200,
                title: "Recompensas",
                child: Text(
                  "oiu",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
