import { Route, Routes, Link } from 'react-router-dom';

export function App() {
  return (
    <div>
      {/* 1. Navegación persistente (se ve en todas las páginas) */}
      <nav>
        <ul>
          <li><Link to="/">Inicio</Link></li>
          <li><Link to="/page-2">Página 2</Link></li>
        </ul>
      </nav>

      <hr />

      {/* 2. Contenido dinámico (cambia según la URL) */}
      <Routes>
        <Route
          path="/"
          element={
            <div>
              <h1>Esta es la Home</h1>
              <p>Acá podrías poner el contenido principal.</p>
            </div>
          }
        />
        <Route
          path="/page-2"
          element={
            <div>
              <h1>Esta es la Página 2</h1>
              <Link to="/">Volver al inicio</Link>
            </div>
          }
        />
      </Routes>
    </div>
  );
}

export default App;