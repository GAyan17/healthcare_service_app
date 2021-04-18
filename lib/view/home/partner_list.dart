import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcare_service_app/cubit/cubit.dart';

class PartnerList extends StatelessWidget {
  const PartnerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PartnerCubit, PartnerState>(
      builder: (context, state) {
        if (state is PartnerRecieved) {
          return ListView.builder(
            itemCount: state.partners.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(state.partners[index].name),
                  subtitle: Text(state.partners[index].organization),
                  onTap: () {
                    print('tapped');
                  },
                ),
              );
            },
          );
        } else {
          return Column(
            children: [
              Center(
                child: CircularProgressIndicator(),
              ),
              const SizedBox(height: 10.0),
              const Text('Loading...'),
            ],
          );
        }
      },
    );
  }
}
