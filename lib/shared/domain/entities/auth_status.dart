enum UserStatus {
  uninitialized, // Arrancando la app
  unauthenticated, // Aún no ha hecho login usuario/clave
  pinRequired, // Ya hizo login, pero falta el PIN
  authenticated, // Ya pasó el PIN: puede navegar libremente
}
