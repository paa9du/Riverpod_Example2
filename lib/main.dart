import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_2/counterdemo.dart';

final counterProvider = StateProvider<int>((ref) => 0);

//sn
// final counterProvider =
//     StateNotifierProvider<CounterDemo, int>((ref) => CounterDemo());

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //State provider is used to store simple mituable objects like bool,string ,num . can;t store complex objects
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //observe the provider state inside the build method.Whenever provider value changes its just rebuild the changes
    final count = ref.watch(counterProvider);
    ref.listen(
      counterProvider,
      ((previous, next) {
        if (next == 10) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("The Value is $next")));
        }
      }),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("State Provider"),
        actions: [
          IconButton(
            onPressed: () {
              // ref.invalidate(counterProvider);
              ref.refresh(counterProvider);
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Center(
        child:
            // Text(count.toString()),
            //sn
            Text('$count'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //  ref.read(counterProvider.notifier).state++;

          //is used to read the provider value once
          // ref.read(counterProvider.notifier).update((state) => state + 1);
          ref.read(counterProvider.state).state++;

          //sn
          // ref.read(counterProvider.notifier).increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
