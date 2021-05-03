import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../partner/partner_page.dart';

class PartnerList extends StatelessWidget {
  const PartnerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PartnerCubit, PartnerState>(
      builder: (ctx, state) {
        if (state is PartnerRecieved) {
          return ListView.builder(
            itemCount: state.partners.length,
            itemBuilder: (_, index) {
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(state.partners[index].name),
                  subtitle: Text(state.partners[index].organization),
                  trailing: Text('Rating: ${state.partners[index].avgRating}'),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) =>
                          PartnerPage(partner: state.partners[index]))),
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
