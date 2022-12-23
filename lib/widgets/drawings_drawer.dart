import 'package:flutter/material.dart';

Drawer drawingsDrawer(BuildContext context) {
  return Drawer(
      child: ListView(
    children: ListTile.divideTiles(tiles: [
      ListTile(
          title: Row(children: const [
            Icon(
              Icons.accessibility,
              semanticLabel: 'Human body',
            ),
            SizedBox(
              width: 4,
              height: 4,
            ),
            Text('Full Body')
          ]),
          onTap: () {}),
      ListTile(
          title: Row(children: const [
            Icon(Icons.back_hand),
            SizedBox(
              width: 4,
              height: 4,
            ),
            Text('Body Part')
          ]),
          onTap: () {}),
      ListTile(
          title: Row(children: const [
            Icon(Icons.pets),
            SizedBox(
              width: 4,
              height: 4,
            ),
            Text('Animal')
          ]),
          onTap: () {}),
      ListTile(
          title: Row(children: const [
            Icon(
              Icons.accessibility,
              semanticLabel: 'Human body',
            ),
            SizedBox(
              width: 4,
              height: 4,
            ),
            Text('Full Body')
          ]),
          onTap: () {}),
      ListTile(
          title: Row(children: const [
            Icon(
              Icons.account_balance,
              semanticLabel: 'Building',
            ),
            SizedBox(
              width: 4,
              height: 4,
            ),
            Text('Structure')
          ]),
          onTap: () {}),
      ListTile(
          title: Row(children: const [
            Icon(
              Icons.apple,
              semanticLabel: 'Fruit',
            ),
            SizedBox(
              width: 4,
              height: 4,
            ),
            Text('Vegetation')
          ]),
          onTap: () {}),
    ], context: context)
        .toList(),
  ));
}
