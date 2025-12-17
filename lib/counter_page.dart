import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:backsystem_desktop_app/counter_cubit.dart';
// 这是UI层，只负责元素渲染，把交互事件转发给BLoc,处理Business logic。
class CounterPage extends StatelessWidget {
  const CounterPage({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      // BlocBuilder负责监听状态变化并更新UI
      body: BlocConsumer<CounterCubit, int>(
        listener: (context, count) {
          print('count: $count');
        },
        builder: (context, count) => Center(child: Text('$count')),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () => context.read<CounterCubit>().increment(),
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () => context.read<CounterCubit>().decrement(),
            icon: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
