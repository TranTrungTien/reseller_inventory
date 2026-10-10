import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../../core/design_system/app_radius.dart';
import '../../../core/design_system/app_spacing.dart';
import '../../../core/design_system/components/app_button.dart';
import '../../../core/design_system/components/label_preview.dart';
import '../../../core/di/providers.dart';
import '../../../core/services/onboarding_service.dart';
import '../../bins/domain/bin.dart';
import '../../workspace/domain/location.dart';
import '../../workspace/domain/workspace.dart';

final onboardingServiceProvider = Provider<OnboardingService>((ref) {
  return OnboardingService();
});

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  int _currentStep = 0;

  String _selectedStorage = 'Garage';
  String _selectedSize = '100-500';

  late TextEditingController _workspaceController;
  late TextEditingController _locationController;
  late TextEditingController _binCodeController;

  String? _createdBinId;

  @override
  void initState() {
    super.initState();
    _workspaceController = TextEditingController(text: 'My Reseller Store');
    _locationController = TextEditingController(text: 'Garage');
    _binCodeController = TextEditingController(text: 'A01');
  }

  @override
  void dispose() {
    _workspaceController.dispose();
    _locationController.dispose();
    _binCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _buildCurrentStep(),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildWelcomeStep();
      case 1:
        return _buildStorageStep();
      case 2:
        return _buildInventorySizeStep();
      case 3:
        return _buildCreateWorkspaceStep();
      case 4:
        return _buildAhaStep();
      default:
        return _buildWelcomeStep();
    }
  }

  Widget _buildWelcomeStep() {
    return Column(
      key: const ValueKey(0),
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(),
        const Icon(Icons.all_inbox_rounded, size: 72, color: Colors.black87),
        const SizedBox(height: AppSpacing.xl),
        Text(
          'Welcome to Binly',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w900,
                color: Colors.black87,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'The fastest physical inventory companion for resellers. Find what sold in seconds.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey.shade700,
              ),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        AppButton(
          label: 'Get Started',
          isFullWidth: true,
          onPressed: () => setState(() => _currentStep = 1),
        ),
      ],
    );
  }

  Widget _buildStorageStep() {
    final options = [
      ('Home', Icons.home_outlined),
      ('Garage', Icons.garage_outlined),
      ('Storage unit', Icons.store_outlined),
      ('Warehouse', Icons.warehouse_outlined),
      ('Multiple locations', Icons.alt_route_outlined),
      ('Other', Icons.more_horiz_outlined),
    ];

    return Column(
      key: const ValueKey(1),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Where do you store your inventory?',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: AppSpacing.xs),
        const Text('Select your main storage setup.'),
        const SizedBox(height: AppSpacing.xl),
        Expanded(
          child: ListView.separated(
            itemCount: options.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) {
              final opt = options[index];
              final isSelected = _selectedStorage == opt.$1;
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedStorage = opt.$1;
                    _locationController.text = opt.$1;
                  });
                },
                borderRadius: AppRadius.borderLg,
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.black87 : Colors.white,
                    borderRadius: AppRadius.borderLg,
                    border: Border.all(
                      color: isSelected ? Colors.black87 : Colors.grey.shade300,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        opt.$2,
                        color: isSelected ? Colors.white : Colors.black87,
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Text(
                        opt.$1,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        AppButton(
          label: 'Continue',
          isFullWidth: true,
          onPressed: () => setState(() => _currentStep = 2),
        ),
      ],
    );
  }

  Widget _buildInventorySizeStep() {
    final sizes = ['<100', '100-500', '500-2,000', '2,000+'];

    return Column(
      key: const ValueKey(2),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'How many active items do you manage?',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: AppSpacing.xs),
        const Text('Estimate your approximate store size.'),
        const SizedBox(height: AppSpacing.xl),
        Expanded(
          child: ListView.separated(
            itemCount: sizes.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) {
              final size = sizes[index];
              final isSelected = _selectedSize == size;
              return InkWell(
                onTap: () => setState(() => _selectedSize = size),
                borderRadius: AppRadius.borderLg,
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.black87 : Colors.white,
                    borderRadius: AppRadius.borderLg,
                    border: Border.all(
                      color: isSelected ? Colors.black87 : Colors.grey.shade300,
                    ),
                  ),
                  child: Text(
                    '$size items',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        AppButton(
          label: 'Continue',
          isFullWidth: true,
          onPressed: () => setState(() => _currentStep = 3),
        ),
      ],
    );
  }

  Widget _buildCreateWorkspaceStep() {
    return Column(
      key: const ValueKey(3),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Create your first Bin',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: AppSpacing.xs),
        const Text(
            'Physical organization starts with your first location and bin.'),
        const SizedBox(height: AppSpacing.xl),
        TextField(
          controller: _workspaceController,
          decoration: const InputDecoration(
            labelText: 'Workspace Name',
            hintText: 'e.g. Reseller Vault',
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        TextField(
          controller: _locationController,
          decoration: const InputDecoration(
            labelText: 'First Location',
            hintText: 'e.g. Garage',
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        TextField(
          controller: _binCodeController,
          decoration: const InputDecoration(
            labelText: 'First Bin Code',
            hintText: 'e.g. A01',
          ),
        ),
        const Spacer(),
        AppButton(
          label: 'Create Bin & Generate Label',
          isFullWidth: true,
          onPressed: _completeSetupAndCreateBin,
        ),
      ],
    );
  }

  Widget _buildAhaStep() {
    return Column(
      key: const ValueKey(4),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(Icons.check_circle_rounded, color: Colors.green, size: 56),
        const SizedBox(height: AppSpacing.md),
        Text(
          'First Bin Ready!',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w900,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xs),
        const Text(
          'Stick this label on your bin to start organizing physical truth.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xl),
        if (_createdBinId != null)
          LabelPreview(
            binId: _createdBinId!,
            binCode: _binCodeController.text.toUpperCase(),
            locationName: _locationController.text,
          ),
        const Spacer(),
        AppButton(
          label: 'ADD FIRST ITEM NOW',
          icon: Icons.add_a_photo,
          isFullWidth: true,
          onPressed: () {
            context.go('/scan');
          },
        ),
        const SizedBox(height: AppSpacing.sm),
        AppButton(
          label: 'Go to Inventory Dashboard',
          isSecondary: true,
          isFullWidth: true,
          onPressed: () {
            context.go('/');
          },
        ),
      ],
    );
  }

  Future<void> _completeSetupAndCreateBin() async {
    final wsName = _workspaceController.text.trim();
    final locName = _locationController.text.trim();
    final binCode = _binCodeController.text.trim().toUpperCase();

    if (wsName.isEmpty || locName.isEmpty || binCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }

    final now = DateTime.now();
    final workspaceId = const Uuid().v4();
    final locationId = const Uuid().v4();
    final binId = const Uuid().v4();

    // Repositories
    final wsRepo = ref.read(workspaceRepositoryProvider);
    final locRepo = ref.read(locationRepositoryProvider);
    final binRepo = ref.read(binRepositoryProvider);
    final onboardingService = ref.read(onboardingServiceProvider);

    // Save Workspace
    await wsRepo.saveWorkspace(
      Workspace(
        id: workspaceId,
        name: wsName,
        createdAt: now,
        updatedAt: now,
      ),
    );

    // Save Location
    await locRepo.saveLocation(
      Location(
        id: locationId,
        workspaceId: workspaceId,
        name: locName,
        createdAt: now,
        updatedAt: now,
      ),
    );

    // Save Bin
    await binRepo.saveBin(
      Bin(
        id: binId,
        workspaceId: workspaceId,
        locationId: locationId,
        code: binCode,
        createdAt: now,
        updatedAt: now,
      ),
    );

    // Save current active workspace ID
    ref.read(currentWorkspaceIdProvider.notifier).state = workspaceId;

    // Mark onboarding complete
    await onboardingService.completeOnboarding(
      storageType: _selectedStorage,
      inventorySize: _selectedSize,
    );

    setState(() {
      _createdBinId = binId;
      _currentStep = 4;
    });
  }
}
