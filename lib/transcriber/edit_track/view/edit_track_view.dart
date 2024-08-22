import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/edit_track_bloc.dart';

class EditTrackView extends StatelessWidget {
  const EditTrackView({super.key});
  
  @override 
  Widget build(BuildContext context) {
    final status = context.select((EditTrackBloc bloc) => bloc.state.status);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        onPressed: status.isLoadingOrSuccess
          ? null
          : () => context.read<EditTrackBloc>().add(const EditTrackSubmitted()),
        child: status.isLoadingOrSuccess
          ? const CupertinoActivityIndicator()
          : const Icon(Icons.check_rounded),
      ),
      body: const CupertinoScrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [_NameField()],
            ),
          ),
        ),
      ),
    );
  }
}

class _NameField extends StatelessWidget {
  const _NameField();

  @override 
  Widget build(BuildContext context) {
    final state = context.watch<EditTrackBloc>().state;
    final hintText = state.track.name;

    return TextFormField(
      key: const Key('editTrackView_name_formField'),
      initialValue: state.name,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'editTrakTitleLabel',
        hintText: hintText,
      ),
      maxLength: 50,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
      onChanged: (value) {
        context.read<EditTrackBloc>().add(EditTrackNameChanged(value));
      }
    );
  }
}
