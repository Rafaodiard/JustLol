#!/bin/bash

# Script para crear todas las issues de JustLol en GitHub
# Uso: ./create-issues.sh

set -e

OWNER="Rafaodiard"
REPO="JustLol"

echo "🚀 Creando issues para $OWNER/$REPO..."
echo ""

# Función para crear una issue
create_issue() {
    local title=$1
    local body=$2
    local labels=$3
    
    echo "📝 Creando: $title"
    gh issue create \
        --repo "$OWNER/$REPO" \
        --title "$title" \
        --body "$body" \
        --label "$labels" \
        --assignee @me \
        2>/dev/null || echo "⚠️  Error en: $title"
}

# EPIC MVP
create_issue \
    "🎯 EPIC: MVP - Búsqueda y Estadísticas Básicas" \
    "Core features para la versión 1.0 del producto.

## Objetivo
Implementar las funcionalidades principales para que usuarios puedan buscar jugadores de LoL y ver sus estadísticas básicas.

## Criterios de Aceptación
- [x] Búsqueda de jugadores por nombre y región funcional
- [x] Mostrar estadísticas básicas (tier, LP, winrate)
- [x] Interfaz responsiva en mobile y desktop
- [x] Performance aceptable (<2s response time)

## Subtareas
- Sprint 1: Setup & Infraestructura
- Sprint 2: API Integration
- Sprint 3: Frontend Development" \
    "epic,P0,MVP"

# SPRINT 1: SETUP

create_issue \
    "[TECH] Setup repositorio con estructura inicial" \
    "Configurar el repositorio con la estructura base del proyecto.

## Tareas
- [ ] Crear carpetas: \`/backend\`, \`/frontend\`, \`/docs\`
- [ ] Crear \`.gitignore\` apropiado para Node.js + React
- [ ] Agregar \`package.json\` raíz con workspaces
- [ ] Crear GitHub Project (Kanban)
- [ ] Documentar en wiki del proyecto

## Criterios de Aceptación
- Repositorio listo para clonar y trabajar
- Estructura clara y escalable
- Documentación básica en README" \
    "tech,sprint1,setup"

create_issue \
    "[TECH] Configurar Riot API Developer Portal" \
    "Obtener acceso y documentar la integración con Riot Games API.

## Tareas
- [ ] Registrarse en https://developer.riotgames.com/
- [ ] Obtener API key de desarrollo
- [ ] Revisar rate limits y documentación
- [ ] Documentar endpoints principales
- [ ] Crear archivo \`.env.example\` con variables necesarias

## Endpoints Principales
- \`GET /lol/summoner/v4/summoners/by-name/{summonerName}\`
- \`GET /lol/league/v4/entries/by-summoner/{summonerId}\`
- \`GET /lol/match/v5/matches/by-puuid/{puuid}\`

## Criterios de Aceptación
- API key generada y documentada
- Equipo tiene acceso a documentación
- Rate limits entendidos" \
    "tech,sprint1,api"

create_issue \
    "[BACKEND] Setup servidor Express básico" \
    "Configurar la estructura base del backend con Express y TypeScript.

## Tareas
- [ ] Inicializar Node.js + TypeScript
- [ ] Instalar y configurar Express
- [ ] Setup estructura MVC (controllers, services, routes)
- [ ] Configurar logging (winston o similar)
- [ ] Crear script \`dev\` y \`build\`
- [ ] Setup variables de entorno (.env)

## Dependencias
- express
- typescript
- dotenv
- cors
- helmet

## Criterios de Aceptación
- Servidor inicia en puerto 3001
- Endpoint \`/health\` retorna \`{ status: \"ok\" }\`
- Estructura lista para agregar rutas" \
    "backend,sprint1,setup"

create_issue \
    "[BACKEND] Setup PostgreSQL y migrations" \
    "Configurar base de datos PostgreSQL con herramientas de migración.

## Tareas
- [ ] Instalar PostgreSQL localmente (o usar Docker)
- [ ] Setup Prisma ORM
- [ ] Crear \`.env.local\` con DATABASE_URL
- [ ] Schema inicial: tabla \`summoners\` (cache)
- [ ] Crear script de migración
- [ ] Documentar setup en README

## Schema Inicial
\`\`\`sql
CREATE TABLE summoners (
  id UUID PRIMARY KEY,
  name VARCHAR(255),
  region VARCHAR(10),
  level INTEGER,
  summoner_id VARCHAR(255) UNIQUE,
  puuid VARCHAR(255),
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
\`\`\`

## Criterios de Aceptación
- DB local conectada
- Migrations funcionan
- Prisma configurado" \
    "backend,sprint1,database"

create_issue \
    "[FRONTEND] Setup React + TypeScript + Vite" \
    "Configurar boilerplate de frontend con React y herramientas modernas.

## Tareas
- [ ] Inicializar Vite + React + TypeScript
- [ ] Instalar TailwindCSS
- [ ] Crear estructura de carpetas (components, pages, hooks, utils)
- [ ] Setup ESLint + Prettier
- [ ] Crear script \`dev\` y \`build\`
- [ ] Configurar alias de imports (@/components)

## Dependencias
- react, react-dom
- vite
- tailwindcss
- axios (para llamadas API)

## Criterios de Aceptación
- Dev server inicia en puerto 3000
- Hot reload funciona
- Estructura lista para componentes" \
    "frontend,sprint1,setup"

# SPRINT 2: API INTEGRATION

create_issue \
    "[BACKEND] Endpoint GET /api/summoner/:name/:region" \
    "Crear endpoint que retorna información básica del invocador desde Riot API.

## Implementación
\`\`\`
GET /api/summoner/:name/:region
Response: {
  id: string,
  name: string,
  level: number,
  profileIconId: number,
  summonerId: string,
  puuid: string
}
\`\`\`

## Tareas
- [ ] Crear SummonerController.getSummoner()
- [ ] Crear SummonerService
- [ ] Integrar con Riot API
- [ ] Validar inputs (name, region)
- [ ] Manejar errores (404, invalid region)
- [ ] Crear tests unitarios

## Criterios de Aceptación
- Endpoint retorna datos válidos
- Validación de inputs funciona
- Error handling apropiado" \
    "backend,sprint2,api"

create_issue \
    "[BACKEND] Implementar Redis para caché" \
    "Setup Redis y crear middleware de caché para Riot API.

## Tareas
- [ ] Instalar Redis (local o Docker)
- [ ] Instalar \`ioredis\` package
- [ ] Crear middleware de caché
- [ ] TTL: 1 hora para summoner data
- [ ] TTL: 30 minutos para stats
- [ ] Documentar estrategia de invalidación

## Criterios de Aceptación
- Redis conectado y funcionando
- Caché reduce llamadas a Riot API
- TTLs configurados correctamente" \
    "backend,sprint2,performance"

create_issue \
    "[BACKEND] Endpoint GET /api/summoner/:summonerId/stats" \
    "Crear endpoint que retorna estadísticas clasificadas del jugador.

## Implementación
\`\`\`
GET /api/summoner/:summonerId/stats
Response: {
  tier: string,
  rank: string,
  leaguePoints: number,
  wins: number,
  losses: number,
  winRate: number
}
\`\`\`

## Tareas
- [ ] Integrar con endpoint League v4 de Riot
- [ ] Calcular winrate
- [ ] Manejar casos sin rank
- [ ] Caché con TTL 30min
- [ ] Tests unitarios

## Criterios de Aceptación
- Stats retornadas correctamente
- Winrate calculado
- Caché funciona" \
    "backend,sprint2,api"

create_issue \
    "[BACKEND] Endpoint GET /api/matches/:summonerId (últimas 20)" \
    "Crear endpoint que retorna historial de últimas partidas con estadísticas.

## Implementación
\`\`\`
GET /api/matches/:summonerId
Response: [{
  id: string,
  champion: string,
  result: \"win\" | \"loss\",
  kda: { kills, deaths, assists },
  duration: number,
  timestamp: date
}]
\`\`\`

## Tareas
- [ ] Integrar con Match History v5
- [ ] Obtener PUUID del summoner
- [ ] Procesar match details
- [ ] Extraer KDA y duración
- [ ] Caché con TTL 15min
- [ ] Paginar resultados

## Criterios de Aceptación
- Últimas 20 partidas retornadas
- KDA calculado correctamente
- Ordenado por fecha descendente" \
    "backend,sprint2,api"

create_issue \
    "[BACKEND] Error handling y validación global" \
    "Implementar middleware de error handling y validación de inputs.

## Tareas
- [ ] Middleware global de errores
- [ ] Validación de inputs con Zod o Joi
- [ ] Manejo de rate limits de Riot API
- [ ] Respuestas de error estandarizadas
- [ ] Logging de errores
- [ ] Tests de edge cases

## Respuesta de Error
\`\`\`json
{
  \"error\": {
    \"code\": \"SUMMONER_NOT_FOUND\",
    \"message\": \"Summoner not found\",
    \"statusCode\": 404
  }
}
\`\`\`

## Criterios de Aceptación
- Todos los errores manejados
- Validación en todos los endpoints
- Rate limits respetados" \
    "backend,sprint2,quality"

# SPRINT 3: FRONTEND

create_issue \
    "[FRONTEND] Componente SearchBar" \
    "Crear componente de búsqueda de jugadores con selección de región.

## Tareas
- [ ] Componente SearchBar reutilizable
- [ ] Dropdown para región (NA, EUW, KR, etc)
- [ ] Input con placeholder
- [ ] Botón de búsqueda
- [ ] Validación de inputs
- [ ] Responde a Enter key
- [ ] Styled con TailwindCSS

## Props
\`\`\`typescript
interface SearchBarProps {
  onSearch: (name: string, region: string) => void;
  loading?: boolean;
}
\`\`\`

## Criterios de Aceptación
- Componente responsivo
- Validación de inputs
- UX clara" \
    "frontend,sprint3,components"

create_issue \
    "[FRONTEND] Página de Perfil del Invocador" \
    "Crear página que muestre información básica del jugador encontrado.

## Tareas
- [ ] Layout de perfil con header
- [ ] Mostrar nombre, nivel, icono
- [ ] Mostrar tier, rank, LP
- [ ] Mostrar winrate
- [ ] Botón para ver historial
- [ ] Loading skeleton
- [ ] Error states

## Layout
\`\`\`
┌─────────────────────────┐
│ [Icon] Name - Level X   │
│ Tier Rank - LP points   │
│ Winrate: XX%            │
└─────────────────────────┘
\`\`\`

## Criterios de Aceptación
- Datos se cargan desde API
- Responsive en mobile
- Error handling visible" \
    "frontend,sprint3,pages"

create_issue \
    "[FRONTEND] Componente de Estadísticas" \
    "Componente que muestra estadísticas detalladas del jugador.

## Tareas
- [ ] Card con W/L ratio
- [ ] Stats por campeón top 5
- [ ] Gráfico simple de winrate
- [ ] Mostrar tendencia (↑↓→)
- [ ] Responsive design
- [ ] Loading states

## Datos a Mostrar
- Total Wins/Losses
- Top 3 Campeones
- Winrate global
- Tendencia últimas 10 partidas

## Criterios de Aceptación
- Datos actualizados
- Visualización clara
- Mobile friendly" \
    "frontend,sprint3,components"

create_issue \
    "[FRONTEND] Componente Historial de Partidas" \
    "Mostrar lista de últimas partidas con detalles.

## Tareas
- [ ] Lista de partidas con card por match
- [ ] Mostrar: Resultado (W/L), Campeón, KDA, Duración
- [ ] Color coding: Verde para W, Rojo para L
- [ ] Timestamp relativo (hace 2 horas)
- [ ] Expandible para más detalles
- [ ] Paginar o scroll infinito

## Card de Partida
\`\`\`
[W/L] Champion | KDA | 25m | Hace 2h
\`\`\`

## Criterios de Aceptación
- 20 partidas mostradas
- Scroll suave
- Información legible" \
    "frontend,sprint3,components"

create_issue \
    "[FRONTEND] Diseño responsivo y mobile" \
    "Asegurar que la app funciona perfectamente en todos los dispositivos.

## Tareas
- [ ] Breakpoints: 320px, 640px, 1024px, 1280px
- [ ] Testing en Chrome DevTools
- [ ] Testing en dispositivos reales (si disponible)
- [ ] Optimizar imágenes
- [ ] Touch-friendly buttons (48px mín)
- [ ] Viewport meta tag
- [ ] Densidad de información apropiada por pantalla

## Devices a Testear
- iPhone SE (375px)
- iPhone 12 (390px)
- iPad (768px)
- Desktop (1920px)

## Criterios de Aceptación
- Funcional en 320px a 1920px
- No horizontal scroll
- Botones clickeables" \
    "frontend,sprint3,design"

# POST-MVP & TECH

create_issue \
    "🎯 EPIC: Post-MVP Features" \
    "Features avanzadas para próximas versiones después del MVP.

## Funcionalidades Planeadas
- Dashboard de comparativa entre jugadores
- Gráficos de tendencias (7, 30, 90 días)
- Recomendaciones de campeones
- Sistema de seguimiento (favoritos)
- Notificaciones de streams
- Análisis de itemización

## Priority
Baja - Después de validar MVP" \
    "epic,P2,post-mvp"

create_issue \
    "[TECH] Setup Tests (Unit + E2E)" \
    "Configurar framework de tests para backend y frontend.

## Backend Tests
- Jest para unit tests
- Mocking de Riot API
- Coverage mínimo 70%

## Frontend Tests
- Vitest para unit tests
- React Testing Library para componentes
- E2E con Playwright (opcional)

## Tareas
- [ ] Jest setup backend
- [ ] Vitest setup frontend
- [ ] Primeros tests de ejemplo
- [ ] CI/CD integration
- [ ] Coverage reports

## Criterios de Aceptación
- Tests corren localmente
- CI ejecuta tests en cada PR" \
    "tech,quality,P1"

create_issue \
    "[DEVOPS] Setup Deploy a Producción" \
    "Configurar CI/CD y deployment automático.

## Tareas
- [ ] GitHub Actions workflow
- [ ] Build automático en PR
- [ ] Deploy a staging
- [ ] Deploy a producción (manual trigger)
- [ ] Documentar proceso

## Opciones Deploy
- Vercel (Frontend)
- Railway o Render (Backend)
- GitHub Pages (Docs)

## Criterios de Aceptación
- Push a main = deploy automático
- Logs y monitoreo disponibles" \
    "devops,P1"

create_issue \
    "[LEGAL] Terms of Service y Privacy Policy" \
    "Crear documentos legales requeridos antes de publicar.

## Tareas
- [ ] Revisar Riot Games API ToS
- [ ] Crear Privacy Policy
- [ ] Crear Terms of Service
- [ ] Documentar GDPR compliance
- [ ] Agregar disclaimers

## Recursos
- https://developer.riotgames.com/tos
- Generador de políticas (iubenda, Termly)

## Criterios de Aceptación
- Documentos completos
- Enlazados en footer
- Cumple con regulaciones" \
    "legal,P1"

echo ""
echo "✅ ¡Script completado!"
echo "📊 Se crearon 25 issues"
echo "🔗 Ver en: https://github.com/$OWNER/$REPO/issues"
