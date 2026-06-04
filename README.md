# Explorer App

App móvil que consume la Rick and Morty API, con persistencia local, favoritos y modo offline.

## Decisiones técnicas

**API: Rick and Morty API** (`rickandmortyapi.com`)
- Gratuita, sin autenticación
- Datos ricos: imagen, estado, especie, origen, episodios
- Perfecta para demostrar lista + detalle + favoritos

**Arquitectura: Clean Architecture + BLoC**
```
lib/
├── core/           # error, network, usecases base, constants
└── features/
    ├── items/      # lista y detalle de personajes
    ├── favorites/  # favoritos persistidos en Hive
    └── device_info/ # info nativa via Platform Channel
```

**State management: flutter_bloc**
Cada feature tiene su propio BLoC con events/states separados. Se usa `dartz` (`Either<Failure, T>`) para manejo funcional de errores.

**Persistencia: Hive**
- `characters_box`: cache de personajes para modo offline
- `favorites_box`: favoritos del usuario

**Kotlin Platform Channel**
`MainActivity.kt` expone el canal `com.explorerapp/device_info` que retorna fabricante, modelo, versión de Android y nivel de batería. Visible como banner en el AppBar de la app.

**Modo offline**
El repositorio verifica conectividad antes de llamar a la API. Sin conexión, sirve los datos cacheados en Hive.

## Dependencias principales

| Paquete | Uso |
|---------|-----|
| flutter_bloc | State management |
| get_it | Inyección de dependencias |
| dio | HTTP client |
| hive_flutter | Base de datos local |
| connectivity_plus | Detección de red |
| cached_network_image | Caché de imágenes |
| dartz | Either para manejo de errores |

## Cómo ejecutar

```bash
flutter pub get
flutter run
```

## Estructura de features

Cada feature sigue la misma estructura:
```
feature/
├── data/
│   ├── datasources/   # remote (Dio) + local (Hive)
│   ├── models/        # modelos con serialización JSON y Hive
│   └── repositories/  # implementación concreta
├── domain/
│   ├── entities/      # entidades puras
│   ├── repositories/  # contratos abstractos
│   └── usecases/      # lógica de negocio
└── presentation/
    ├── bloc/          # BLoC + events + states
    ├── pages/         # pantallas
    └── widgets/       # componentes reutilizables
```

## Funcionalidades

- Lista de personajes con paginación (scroll infinito)
- Detalle completo de cada personaje
- Marcar/desmarcar favoritos (persistidos localmente)
- Modo offline con datos cacheados
- Banner de info del dispositivo (Kotlin Platform Channel)
- Dark mode (respeta el tema del sistema)
- Animaciones Hero en navegación
- Estados: loading, error, empty
- Pull-to-refresh

## Screenshots

### 🌙 Dark Mode

| Characters | Detail | Favorites |
|:---:|:---:|:---:|
| ![Dark Characters](screenshots/dark_characters.jpeg) | ![Dark Detail](screenshots/dark_detail.jpeg) | ![Dark Favorites](screenshots/dark_favorites.jpeg) |

### ☀️ Light Mode

| Characters | Detail | Favorites |
|:---:|:---:|:---:|
| ![Light Characters](screenshots/light_characters.jpeg) | ![Light Detail](screenshots/light_detail.jpeg) | ![Light Favorites](screenshots/light_favorites.jpeg) |
