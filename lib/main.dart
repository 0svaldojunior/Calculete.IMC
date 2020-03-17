import 'package:flutter/material.dart';

void main() {
  	runApp(MaterialApp(
  		home: Home(),
  	));
}

class Home extends StatefulWidget {
  	@override
  	_HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

	TextEditingController wightController = TextEditingController();
	TextEditingController heightController = TextEditingController();

	GlobalKey<FormState> _formKey = GlobalKey<FormState>();

	String _infoText = "Informe Seus Dados";

	void _resetField() {
		wightController.text = "";
		heightController.text = "";
		setState(() {
			_infoText = "Infome Seus Dados"; 
		});
	}

	void _calculete() {
		setState(() {
		  	double weight = double.parse(wightController.text);
			double height = double.parse(heightController.text) / 100;
			double imc =  weight /  (height * height);
			print(imc);

			if(imc < 18.6 && imc > 10) {
				_infoText = "Seu IMC é: ${imc.toStringAsPrecision(4)}.toString \n você está legal.";
			} else if (imc > 18.6) {
				_infoText = "Seu IMC é: ${imc.toStringAsPrecision(4)} \n olha a obesidade.";
			} else {
				_infoText = "Seu IMC é: ${imc.toStringAsPrecision(4)} \n muito seco.";
			}
		});	
	}
	
  	@override
  	Widget build(BuildContext context) {
  	  	return Scaffold(
			appBar: AppBar(
				title: Text("Calculadora de IMC"),
				centerTitle: true,
				backgroundColor: Colors.green,
				actions: <Widget>[
					IconButton(
						icon: Icon(Icons.refresh),
						onPressed: _resetField,
					)
				],
			),
			
			backgroundColor: Colors.white,
			body: SingleChildScrollView(
				padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
				child: Form(
					key: _formKey,
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.stretch,
						children: <Widget>[
							Icon(
								Icons.person_outline, 
								size: 120.0, color: Colors.green
							),

							TextFormField(
								keyboardType: TextInputType.number,
								decoration: InputDecoration(
									labelText: "Peso (kg)",
									labelStyle:  TextStyle(color: Colors.green)
								),
								textAlign: TextAlign.center,
								style: TextStyle(color: Colors.green, fontSize: 25.0),
								controller: wightController,
								validator: (value) {
									if(value.isEmpty) {
										return "Insira seu peso!";
									}
								},
							),

							TextFormField(
								keyboardType: TextInputType.number,
								decoration: InputDecoration(
									labelText: "Altura (cm)",
									labelStyle:  TextStyle(color: Colors.green)
								),
								textAlign: TextAlign.center,
								style: TextStyle(color: Colors.green, fontSize: 25.0),
								controller: heightController,
								validator: (value) {
									if(value.isEmpty) {
										return "Insira sua Altura!";
									}
								},
							),

							Padding(
								padding: EdgeInsets.all(10.0),
								child: Container(
									height: 50.0,
									child: RaisedButton(
										onPressed: () {
											if(_formKey.currentState.validate())
											_calculete();
										},
										child: Text(
											"Calcular",
											style: TextStyle(color: Colors.white, fontSize: 25.0),
										),
										color: Colors.green,
									),
								),
							),

							Padding(
								padding: EdgeInsets.all(10.0),
								child: Text(
									_infoText,
									textAlign: TextAlign.center,
									style: TextStyle(color: Colors.green, fontSize: 25.0),
								),
							)
						],
					),
				)
			),
  		);
  	}
}