import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector64;
import 'package:flutter/services.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class ArScreen extends StatefulWidget {
  const ArScreen({Key? key}) : super(key: key);

  @override
  State<ArScreen> createState() => _ArScreenState();
}

class _ArScreenState extends State<ArScreen> {
  // late ArCoreController coreController;

  late UnityWidgetController _unityWidgetController;

  /*augmentedRealityViewCreated(ArCoreController controller) {
    coreController = controller;

    displayCube(coreController!);
  }*/

  /*displayCube(ArCoreController controller) {
    final materials = ArCoreMaterial(
      color: Colors.amberAccent,
      metallic: 2,

    );

    final cube = ArCoreCube(
        size: vector64.Vector3(0.5,0.5,0.5),
        materials: [materials],
    );

    final node = ArCoreNode(
      shape: cube,
      position: vector64.Vector3(-0.5,0.5,-3.5),
    );

    coreController!.addArCoreNode(node);

  }*/

  /*void _handleOnPlaneTap(List<ArCoreHitTestResult> hits) {
    final hit = hits.first;

    final moonMaterial = ArCoreMaterial(color: Colors.grey);

    final moonShape = ArCoreSphere(
      materials: [moonMaterial],
      radius: 0.03,
    );

    final moon = ArCoreNode(
      shape: moonShape,
      position: vector64.Vector3(0.2, 0, 0),
      rotation: vector64.Vector4(0, 0, 0, 0),
    );

    final earthMaterial = ArCoreMaterial(
        color: Color.fromARGB(120, 66, 134, 244));

    final earthShape = ArCoreSphere(
      materials: [earthMaterial],
      radius: 0.1,
    );

    final earth = ArCoreNode(
        shape: earthShape,
        children: [moon],
        position: vector64.Vector3(0.0, 1.0, 0.0),
        rotation: vector64.Vector4(0.0, 1.0, 0.0,1.0)
    );

    coreController.addArCoreNodeWithAnchor(earth);
  }

  void onTapHandler(String name) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(content: Text('onNodeTap on $name')),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    coreController = controller;
    coreController.onNodeTap = (name) => onTapHandler(name);
    coreController.onPlaneTap = _handleOnPlaneTap;
    _addImage(controller);
    _addImage2(controller);
  }

  Future<Uint8List> getImageBytes(String imageName) async {
    final ByteData data = await rootBundle.load('assets/$imageName');
    return data.buffer.asUint8List();
  }

  void _addImage(ArCoreController controller) async {
    final imagebytes = await getImageBytes("theme/Venue-Interior-1.jpg");
    final node = ArCoreNode(
      image:ArCoreImage(bytes:imagebytes,width:300,height:500),
      position: vector64.Vector3(0, 0, -0.5),
    );
    controller.addArCoreNode(node);
  }

  void _addImage2(ArCoreController controller) async {
    final imagebytes = await getImageBytes("theme/romantic.jpg");
    final node = ArCoreNode(
      image:ArCoreImage(bytes:imagebytes,width:200,height:200),
      position: vector64.Vector3(0, 0, -0.5),
    );
    controller.addArCoreNode(node);
  }*/

  @override
  void dispose() {
    // coreController.dispose();
    _unityWidgetController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     body: ArCoreView(
    //       onArCoreViewCreated: _onArCoreViewCreated,
    //       enableTapRecognizer: true,
    //     ),
    //   );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Unity Screen"),
      ),
      body: SafeArea(
        bottom: false,
        child: PopScope(
          canPop: true,
          child: Container(
            color: Colors.yellow,
            child: UnityWidget(
              onUnityCreated: onUnityCreated,
            ),
          ),
        ),
      ),
    );

  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    _unityWidgetController = controller;
  }

  void onUnityMessage(message) {
    print('Received message from unity: ${message.toString()}');
  }

  changeCurrentLevel(String value) {
    _unityWidgetController.postMessage(
      'LevelController',
      'ChangeCurrentLevel',
      value,
    );
  }
}