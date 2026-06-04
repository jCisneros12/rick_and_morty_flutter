import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/device_info_bloc.dart';

class DeviceInfoBanner extends StatelessWidget {
  const DeviceInfoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceInfoBloc, DeviceInfoState>(
      builder: (context, state) {
        if (state is DeviceInfoLoaded) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Row(
              children: [
                const Icon(Icons.phone_android, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${state.info.manufacturer} ${state.info.model} · Android ${state.info.androidVersion}',
                    style: Theme.of(context).textTheme.labelSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  state.info.batteryLevel > 20 ? Icons.battery_full : Icons.battery_alert,
                  size: 16,
                  color: state.info.batteryLevel > 20 ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 4),
                Text(
                  '${state.info.batteryLevel}%',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
