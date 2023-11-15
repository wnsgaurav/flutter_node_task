
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:task/cubit/ServiceCubit.dart';
import 'package:task/cubit/ServiceCheckboxState.dart';
import 'package:task/modal/servicemodal.dart';
import 'package:task/ui/second_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ServiceModal> serviceList = [
    ServiceModal(id: 1, name: "Service 1", cheked: false),
    ServiceModal(id: 2, name: "Service 2", cheked: false),
    ServiceModal(id: 3, name: "Service 3", cheked: false),
    ServiceModal(id: 4, name: "Service 4", cheked: false),
    ServiceModal(id: 5, name: "Service 5", cheked: false),
    ServiceModal(id: 6, name: "Service 6", cheked: false),
    ServiceModal(id: 7, name: "Service 7", cheked: false),
    ServiceModal(id: 8, name: "Service 8", cheked: false)
  ];

  late int id;

  int itemCount = 0;
  bool addService = true;
  int count = 0;

  @override
  void initState() {
    getCount();
    super.initState();
  }

  getCount() {
    for (var element in serviceList) {
      if (element.cheked == true) {
        itemCount++;
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Task'),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SecondScreen()));
            },
            label: const Text('Next Screen')),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          color: Colors.black,
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 1,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4
              ),
              itemCount: serviceList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(6, 4, 6, 4),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        boxShadow: [
                          BoxShadow(
                            // color: Colors.grey.withOpacity(0.3),
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/yoga.jpeg',
                                height: 80,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ],
                          ),
                          Positioned(
                              bottom: 4,
                              right: 8,
                              child: BlocBuilder<CheckboxCubit, CheckboxState>(
                                  builder: (context, state) {
                                if (state is CheckBoxCheckedState) {
                                  addService = state.checkState;
                                  count = state.count;
                                }
                                return MSHCheckbox(
                                  size: 18,
                                  value: serviceList[index].cheked!,
                                  colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                                    checkedColor: Colors.black,
                                  ),
                                  style: MSHCheckboxStyle.fillScaleColor,
                                  onChanged: (value) {
                                    setState(() {
                                      if (addService) {
                                        id = serviceList[index].id!;
                                        serviceList[index].cheked = value;
                                        context.read<CheckboxCubit>().countCheck(value, serviceList[index],count);
                                      }else{
                                        if(addService || !value){
                                          serviceList[index].cheked = value;
                                          context.read<CheckboxCubit>().countCheck(value, serviceList[index],count);
                                        }
                                      }
                                      setState(() {});
                                    });
                                  },
                                );
                                  }))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      serviceList[index].name.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ],
                );
              }),
        )

        );
  }
}
