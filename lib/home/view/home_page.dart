import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muse/home/home.dart';
import 'package:muse/metronome/metronome.dart';
import 'package:muse/transcriber/transcriber_overview/transcriber_overview.dart';
import 'package:muse/tuner/tuner.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override 
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);

    return Scaffold(
      body: IndexedStack(
        index: selectedTab.index,
        children: const [MetronomePage(), TunerPage(), TranscriberOverviewPage()],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _HomeTabButton(
              groupValue: selectedTab,
              value: HomeTab.metronome,
              icon: const Icon(Icons.timer),
            ),
            _HomeTabButton(
              groupValue: selectedTab,
              value: HomeTab.tuner,
              icon: const Icon(Icons.music_note_rounded),
            ),
            _HomeTabButton(
              groupValue: selectedTab,
              value: HomeTab.transcriber,
              icon: const Icon(Icons.hearing),
            )
          ]
        )
      )
    );
  } 
}

class _HomeTabButton extends StatelessWidget {
  const _HomeTabButton({
    required this.groupValue,
    required this.value,
    required this.icon,
  });

  final HomeTab groupValue;
  final HomeTab value;
  final Widget icon;

  @override 
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<HomeCubit>().setTab(value),
      iconSize: 32,
      color: groupValue != value ? null : Theme.of(context).colorScheme.secondary,
      icon: icon,
    );
  }
}

