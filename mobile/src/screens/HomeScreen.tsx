import React from 'react';
import { View, Text, StyleSheet, Button } from 'react-native';
import { HomeScreenProps } from '../types/navigation';

export default function HomeScreen({ navigation }: HomeScreenProps) {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Welcome to Home Screen</Text>
      <View style={styles.buttonContainer}>
        <Button
          title="Go to Details"
          onPress={() => navigation.navigate('Details', { id: '123' })}
        />
        <Button
          title="Go to Profile"
          onPress={() => navigation.navigate('Profile', { userId: 'user123' })}
        />
      </View>
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
    marginBottom: 20,
  },
  buttonContainer: {
    gap: 10,
    width: '100%',
  },
});