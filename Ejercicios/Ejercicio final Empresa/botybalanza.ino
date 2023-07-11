#include <Wire.h>
#include <HX711.h>
#include <LiquidCrystal_I2C.h>
#include <Keypad.h>

LiquidCrystal_I2C lcd(0x27, 16, 2);

const byte FILAS = 4;
const byte COLUMNAS = 4;
char teclas[FILAS][COLUMNAS] = {
  {'1','4','7','*'},
  {'2','5','8','0'},
  {'3','6','9','#'},
  {'A','B','C','D'}
};

byte pinesFilas[FILAS] = {6, 7, 8, 9};
byte pinesColumnas[COLUMNAS] = {2, 3, 4, 5};
Keypad teclado = Keypad(makeKeymap(teclas), pinesFilas, pinesColumnas, FILAS, COLUMNAS);

String pesoIngresado = "";
int aguaConsumida = 0;
int aguaDiaria = 0;
int pesoBotellaAnterior = 0;

enum Estado {
  INGRESO_PESO,
  MOSTRAR_AGUA,
  TOMAR_AGUA
};

Estado estado = INGRESO_PESO;

const int DOUT = A0;
const int CLK = A1;

HX711 balanza;

void setup() {
  Serial.begin(9600);
  balanza.begin(DOUT, CLK);
  balanza.set_scale(-467448.276); // Establecemos la escala
  balanza.tare(20);  // El peso actual es considerado Tara.
  
  lcd.init();
  lcd.backlight();
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("Ingrese su peso:");
}

void loop() {
  Serial.print("Peso: ");
  Serial.print(balanza.get_units(20), 3);
  Serial.println(" kg");
  delay(500);
  char tecla = teclado.getKey();

  if (tecla == '*') {
    asm volatile ("jmp 0");
  }

  if (tecla) {
    if (estado == INGRESO_PESO) {
      if (tecla == '#') {
        estado = MOSTRAR_AGUA;
        int pesoUsuario = pesoIngresado.toInt();
        aguaDiaria = pesoUsuario * 28;
        lcd.clear();
        lcd.setCursor(0, 0);
        lcd.print("Bebido: ");
        lcd.print(aguaConsumida);
        lcd.print(" ml");
        lcd.setCursor(0, 1);
        lcd.print("Peso: ");
        lcd.print(pesoIngresado);
        lcd.print(" kg");
        lcd.setCursor(0, 2);
        lcd.print("Resta: ");
        lcd.print(aguaDiaria - aguaConsumida);
        lcd.print(" ml");
        pesoBotellaAnterior = obtenerPesoBotella();
      } else {
        pesoIngresado += tecla;
        lcd.setCursor(0, 1);
        lcd.print("Peso: ");
        lcd.print(pesoIngresado);
      }
    } else if (estado == MOSTRAR_AGUA) {
      lcd.clear();
      lcd.setCursor(0, 0);
      lcd.print("Bebido: ");
      lcd.print(aguaConsumida);
      lcd.print(" ml");
      lcd.setCursor(0, 1);
      lcd.print("Peso: ");
      lcd.print(pesoIngresado);
      lcd.print(" kg");
      lcd.setCursor(0, 2);
      lcd.print("Resta: ");
      lcd.print(aguaDiaria - aguaConsumida);
      lcd.print(" ml");

      if (tecla == '#') {
        estado = TOMAR_AGUA;
        int pesoBotellaActual = obtenerPesoBotella();
        int diferenciaPeso = pesoBotellaAnterior - pesoBotellaActual;
        int mlPorGramo = 1;
        int mlConsumidos = diferenciaPeso * mlPorGramo;

        aguaConsumida += mlConsumidos;

        pesoBotellaAnterior = pesoBotellaActual;
      }
    }
  }

  Serial.print("Peso actual: ");
  Serial.println(obtenerPesoBotella());

  delay(500);
}

int obtenerPesoBotella() {
  int pesoActual = balanza.get_units(20);
  return pesoActual;
}