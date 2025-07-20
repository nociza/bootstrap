import React from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { DetailsScreenProps } from '../types/navigation';

export default function DetailsScreen({ route }: DetailsScreenProps) {
  const { id } = route.params;

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Details Screen</Text>
      <Text style={styles.text}>Item ID: {id}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    padding: 20,
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 10,
  },
  text: {
    fontSize: 16,
  },
});