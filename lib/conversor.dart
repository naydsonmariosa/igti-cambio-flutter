import 'package:flutter/material.dart';

class Conversor extends StatefulWidget {
  const Conversor({Key key}) : super(key: key);

  @override
  _ConversorState createState() => _ConversorState();
}

class _ConversorState extends State<Conversor> {

  final TextEditingController _realControler = TextEditingController();
  final TextEditingController _dolarControler = TextEditingController();
  var _resultado = '';
  final key = GlobalKey<ScaffoldState>();

  _onItemTapped(int index, BuildContext context){
   if(index == 0){
      if(_realControler.text.isNotEmpty && _dolarControler.text.isNotEmpty){
        try {
          var quantReais = double.parse(_realControler.text);
          var cotDolar = double.parse(_dolarControler.text);
          var resultado = quantReais / cotDolar;

          setState(() {
            // seta o valor do reusltado
            _resultado = 'Com $quantReais é possível comprar ${resultado.toStringAsFixed(2)} dolares a cada $cotDolar';
          });

        }catch(e){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
              content: Text('Algum dado inválido foi informado.'),
            )
          );
        }
      } else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Preencha todos os campos.'),
            )
        );

      }
    }
     else if(index == 1){
       _realControler.clear();
       setState(() {
         _resultado = '';
       });
     }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text('Reais para Dólares'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            'assets/icone.png',
            height: 100,
            width: 100,
          ),
          TextField(
            controller: _realControler,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
                hintText: "Quantidade de Reais",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                )
            ),
          ),
          TextField(
            controller: _dolarControler,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
                hintText: "Cotação do Dolar",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                )
            ),
          ),
          Text('$_resultado', style: TextStyle(fontSize: 30),),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.blueAccent,
          fixedColor: Colors.white,
          unselectedItemColor: Colors.white,
          onTap: (value) => _onItemTapped(value, context),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.circle, color: Colors.white, size: 20,),
              label: 'Calcular',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.clear, color: Colors.white, size: 20),
              label: 'Limpar',
            )
          ]
      ),
    );
  }
}
