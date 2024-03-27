import 'package:flutter/material.dart';

class MyBody extends StatefulWidget {
  const MyBody({Key? key}) : super(key: key);

  @override
  _MyBodyState createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> {
  //per controllare il testo inserito dall'utente
  TextEditingController _cityController = TextEditingController();

  List<String> _addedCities = [];
  bool _isAddingCity = false;

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 29, right: 29),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          const Text(
            "Edit Itinerary", 
            style: TextStyle(
              color: Color.fromRGBO(45, 45, 45, 1),
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          _buildDayNavigation(),
          const SizedBox(height: 30),
          
         
          if (_isAddingCity || _addedCities.isNotEmpty)
            _buildAddedCities(),
          const SizedBox(height: 10),
          _buildCityCard(),
        ],
      ),
    );
  }

  Widget _buildDayNavigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios),
        ),
        const Text("Day 1"),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }

  Widget _buildAddedCities() {
    return ListView.builder(
      //shrinkWrap -> la lista occupa solo lo spazio necessario a seconda deglki elementi
      shrinkWrap: true,
      itemCount: _addedCities.length,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: [
            Icon(Icons.radio_button_unchecked,),
            const SizedBox(width:30),
            Text(_addedCities[index], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),

          ],
        );
      },
    );
  }

  Widget _buildCityCard() {
    return Card(
      elevation: 0,
      child: Column(
        children: [
          if (!_isAddingCity)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isAddingCity = true;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.add),
                  const SizedBox(width: 8),
                  const Text("Add a city",
                      style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
          if (_isAddingCity)
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      hintText: 'Enter a city',
                    ),
                    onSubmitted: (value) {
                      setState(() {
                        _addedCities.add(value);
                        _cityController.clear();
                        _isAddingCity = false;
                      });
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isAddingCity = false;
                    });
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
