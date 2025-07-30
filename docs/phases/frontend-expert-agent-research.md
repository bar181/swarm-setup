# Frontend Expert Agent Research - 2025 Best Practices

## Table of Contents
1. [React 2025 Best Practices](#react-2025-best-practices)
2. [TypeScript Strict Mode](#typescript-strict-mode)
3. [State Management](#state-management)
4. [Performance Optimization](#performance-optimization)
5. [Accessibility (WCAG 2.1 AA)](#accessibility-wcag-21-aa)
6. [CSS/Styling](#cssstyling)
7. [Testing Frontend](#testing-frontend)
8. [Build Tools](#build-tools)

---

## React 2025 Best Practices

### Server Components Best Practices

```typescript
// app/products/page.tsx - Server Component
async function ProductList() {
  // Direct database query in Server Component
  const products = await db.query('SELECT * FROM products');
  
  return (
    <div className="product-grid">
      {products.map(product => (
        <ProductCard key={product.id} product={product} />
      ))}
    </div>
  );
}

// ProductCard.tsx - Client Component for interactivity
'use client';

export function ProductCard({ product }) {
  const [isLiked, setIsLiked] = useState(false);
  
  return (
    <div className="product-card">
      <h3>{product.name}</h3>
      <button onClick={() => setIsLiked(!isLiked)}>
        {isLiked ? '❤️' : '🤍'}
      </button>
    </div>
  );
}
```

### Suspense and Streaming

```typescript
// Streaming with Suspense boundaries
import { Suspense } from 'react';

export default function Dashboard() {
  return (
    <div className="dashboard">
      <Header />
      
      <Suspense fallback={<LoadingSkeleton />}>
        <Analytics />
      </Suspense>
      
      <Suspense fallback={<ChartSkeleton />}>
        <RevenueChart />
      </Suspense>
      
      <Suspense fallback={<TableSkeleton />}>
        <OrdersTable />
      </Suspense>
    </div>
  );
}

// Fine-grained loading states
function LoadingSkeleton() {
  return (
    <div className="animate-pulse">
      <div className="h-4 bg-gray-200 rounded w-3/4"></div>
      <div className="h-4 bg-gray-200 rounded w-1/2 mt-2"></div>
    </div>
  );
}
```

### Concurrent Features

```typescript
import { startTransition, useTransition, useDeferredValue } from 'react';

function SearchResults({ query }) {
  const [isPending, startTransition] = useTransition();
  const [results, setResults] = useState([]);
  
  // Mark search as non-urgent update
  const handleSearch = (value) => {
    startTransition(() => {
      setResults(performSearch(value));
    });
  };
  
  // Defer expensive rendering
  const deferredQuery = useDeferredValue(query);
  
  return (
    <div>
      {isPending && <Spinner />}
      <ResultsList query={deferredQuery} />
    </div>
  );
}
```

---

## TypeScript Strict Mode

### tsconfig.json Configuration

```json
{
  "compilerOptions": {
    "strict": true,                      // Enable all strict checks
    "noImplicitAny": true,              // Error on expressions with 'any'
    "strictNullChecks": true,           // Enable strict null checks
    "strictFunctionTypes": true,        // Strict checking of function types
    "strictBindCallApply": true,        // Strict 'bind', 'call', and 'apply'
    "strictPropertyInitialization": true, // Strict property initialization
    "noImplicitThis": true,             // Error on 'this' with implied 'any'
    "alwaysStrict": true,               // Parse in strict mode
    "exactOptionalPropertyTypes": true,  // Exact optional property types
    "noUncheckedIndexedAccess": true    // Add undefined to index signatures
  }
}
```

### Advanced Type Safety Patterns

```typescript
// Generic constraints with utility types
type ReadOnlyDeep<T> = {
  readonly [P in keyof T]: T[P] extends object ? ReadOnlyDeep<T[P]> : T[P];
};

// Type guards for runtime safety
interface User {
  id: number;
  name: string;
  email: string;
  role: 'admin' | 'user';
}

function isUser(obj: unknown): obj is User {
  return (
    typeof obj === 'object' &&
    obj !== null &&
    'id' in obj &&
    'name' in obj &&
    'email' in obj &&
    'role' in obj &&
    typeof (obj as User).id === 'number' &&
    typeof (obj as User).name === 'string' &&
    typeof (obj as User).email === 'string' &&
    ['admin', 'user'].includes((obj as User).role)
  );
}

// Template literal types for API routes
type APIRoute = `/api/${string}`;
type HTTPMethod = 'GET' | 'POST' | 'PUT' | 'DELETE';

interface APIEndpoint<T = unknown> {
  route: APIRoute;
  method: HTTPMethod;
  response: T;
}

// Const assertions for immutable configurations
const ROUTES = {
  HOME: '/',
  DASHBOARD: '/dashboard',
  PROFILE: '/profile'
} as const;

type Route = typeof ROUTES[keyof typeof ROUTES];
```

### Utility Types in Practice

```typescript
// Custom utility types combining built-ins
type PartialExcept<T, K extends keyof T> = Partial<T> & Pick<T, K>;

interface Product {
  id: string;
  name: string;
  price: number;
  description: string;
  inStock: boolean;
}

// ID is required, rest is optional
type ProductUpdate = PartialExcept<Product, 'id'>;

// Advanced mapped types
type Getters<T> = {
  [K in keyof T as `get${Capitalize<string & K>}`]: () => T[K];
};

type ProductGetters = Getters<Product>;
// Results in:
// {
//   getId: () => string;
//   getName: () => string;
//   getPrice: () => number;
//   getDescription: () => string;
//   getInStock: () => boolean;
// }
```

---

## State Management

### Zustand (Recommended for Most Projects)

```typescript
// store/useAppStore.ts
import { create } from 'zustand';
import { devtools, persist, subscribeWithSelector } from 'zustand/middleware';
import { immer } from 'zustand/middleware/immer';

interface User {
  id: string;
  name: string;
  email: string;
}

interface AppState {
  // State
  user: User | null;
  theme: 'light' | 'dark';
  notifications: Notification[];
  
  // Actions
  setUser: (user: User | null) => void;
  toggleTheme: () => void;
  addNotification: (notification: Notification) => void;
  clearNotifications: () => void;
}

export const useAppStore = create<AppState>()(
  devtools(
    persist(
      subscribeWithSelector(
        immer((set) => ({
          // Initial state
          user: null,
          theme: 'light',
          notifications: [],
          
          // Actions with Immer for immutability
          setUser: (user) => set((state) => {
            state.user = user;
          }),
          
          toggleTheme: () => set((state) => {
            state.theme = state.theme === 'light' ? 'dark' : 'light';
          }),
          
          addNotification: (notification) => set((state) => {
            state.notifications.push(notification);
          }),
          
          clearNotifications: () => set((state) => {
            state.notifications = [];
          })
        }))
      ),
      {
        name: 'app-storage',
        partialize: (state) => ({ user: state.user, theme: state.theme })
      }
    )
  )
);

// Selectors for performance
export const useUser = () => useAppStore((state) => state.user);
export const useTheme = () => useAppStore((state) => state.theme);
```

### Redux Toolkit (For Complex Apps)

```typescript
// store/slices/userSlice.ts
import { createSlice, createAsyncThunk, PayloadAction } from '@reduxjs/toolkit';

interface UserState {
  data: User | null;
  loading: boolean;
  error: string | null;
}

export const fetchUser = createAsyncThunk(
  'user/fetch',
  async (userId: string) => {
    const response = await api.getUser(userId);
    return response.data;
  }
);

const userSlice = createSlice({
  name: 'user',
  initialState: {
    data: null,
    loading: false,
    error: null
  } as UserState,
  reducers: {
    setUser: (state, action: PayloadAction<User>) => {
      state.data = action.payload;
    },
    clearUser: (state) => {
      state.data = null;
    }
  },
  extraReducers: (builder) => {
    builder
      .addCase(fetchUser.pending, (state) => {
        state.loading = true;
        state.error = null;
      })
      .addCase(fetchUser.fulfilled, (state, action) => {
        state.loading = false;
        state.data = action.payload;
      })
      .addCase(fetchUser.rejected, (state, action) => {
        state.loading = false;
        state.error = action.error.message || 'Failed to fetch user';
      });
  }
});

export const { setUser, clearUser } = userSlice.actions;
export default userSlice.reducer;
```

### Jotai (For Atomic State)

```typescript
// atoms/index.ts
import { atom, useAtom } from 'jotai';
import { atomWithStorage } from 'jotai/utils';

// Primitive atoms
export const userAtom = atomWithStorage<User | null>('user', null);
export const themeAtom = atomWithStorage<'light' | 'dark'>('theme', 'light');

// Derived atoms
export const isAuthenticatedAtom = atom((get) => get(userAtom) !== null);

// Async atoms
export const userProfileAtom = atom(
  async (get) => {
    const user = get(userAtom);
    if (!user) return null;
    
    const response = await fetch(`/api/users/${user.id}/profile`);
    return response.json();
  }
);

// Write-only atoms for actions
export const logoutAtom = atom(
  null,
  (get, set) => {
    set(userAtom, null);
    // Clear other related atoms
  }
);

// Component usage
function UserProfile() {
  const [user] = useAtom(userAtom);
  const [profile] = useAtom(userProfileAtom);
  const [, logout] = useAtom(logoutAtom);
  
  return (
    <div>
      <h1>{user?.name}</h1>
      <button onClick={logout}>Logout</button>
    </div>
  );
}
```

---

## Performance Optimization

### Memoization Strategies

```typescript
// Smart memoization with React.memo
interface ExpensiveListProps {
  items: Item[];
  onItemClick: (id: string) => void;
}

const ExpensiveList = React.memo<ExpensiveListProps>(
  ({ items, onItemClick }) => {
    console.log('ExpensiveList rendered');
    
    return (
      <ul>
        {items.map(item => (
          <li key={item.id} onClick={() => onItemClick(item.id)}>
            {item.name}
          </li>
        ))}
      </ul>
    );
  },
  // Custom comparison function
  (prevProps, nextProps) => {
    return (
      prevProps.items.length === nextProps.items.length &&
      prevProps.items.every((item, index) => 
        item.id === nextProps.items[index].id
      )
    );
  }
);

// useMemo for expensive computations
function DataVisualization({ data }: { data: DataPoint[] }) {
  const processedData = useMemo(() => {
    console.log('Processing data...');
    return data
      .filter(point => point.value > 0)
      .sort((a, b) => b.value - a.value)
      .map(point => ({
        ...point,
        percentage: (point.value / total) * 100
      }));
  }, [data]);
  
  return <Chart data={processedData} />;
}

// useCallback for stable references
function SearchableList({ items }: { items: Item[] }) {
  const [search, setSearch] = useState('');
  
  const handleSearch = useCallback((value: string) => {
    console.log('Search:', value);
    setSearch(value);
  }, []);
  
  const filteredItems = useMemo(() => 
    items.filter(item => 
      item.name.toLowerCase().includes(search.toLowerCase())
    ),
    [items, search]
  );
  
  return (
    <>
      <SearchInput onSearch={handleSearch} />
      <ItemList items={filteredItems} />
    </>
  );
}
```

### Code Splitting and Lazy Loading

```typescript
// Route-based code splitting
import { lazy, Suspense } from 'react';
import { Routes, Route } from 'react-router-dom';

// Lazy load route components
const Dashboard = lazy(() => import('./pages/Dashboard'));
const Profile = lazy(() => import('./pages/Profile'));
const Settings = lazy(() => import('./pages/Settings'));

// Preload components on hover
function preloadComponent(component: () => Promise<any>) {
  component();
}

function App() {
  return (
    <Routes>
      <Route path="/" element={
        <Link 
          to="/dashboard" 
          onMouseEnter={() => preloadComponent(() => import('./pages/Dashboard'))}
        >
          Dashboard
        </Link>
      } />
      
      <Route path="/dashboard" element={
        <Suspense fallback={<PageLoader />}>
          <Dashboard />
        </Suspense>
      } />
      
      <Route path="/profile" element={
        <Suspense fallback={<PageLoader />}>
          <Profile />
        </Suspense>
      } />
    </Routes>
  );
}

// Component-level code splitting
const HeavyComponent = lazy(() => 
  import('./components/HeavyComponent').then(module => ({
    default: module.HeavyComponent
  }))
);

// Intersection Observer for lazy loading
function LazyImage({ src, alt }: { src: string; alt: string }) {
  const [isIntersecting, setIsIntersecting] = useState(false);
  const imgRef = useRef<HTMLImageElement>(null);
  
  useEffect(() => {
    const observer = new IntersectionObserver(
      ([entry]) => {
        if (entry.isIntersecting) {
          setIsIntersecting(true);
          observer.disconnect();
        }
      },
      { threshold: 0.1 }
    );
    
    if (imgRef.current) {
      observer.observe(imgRef.current);
    }
    
    return () => observer.disconnect();
  }, []);
  
  return (
    <div ref={imgRef}>
      {isIntersecting ? (
        <img src={src} alt={alt} loading="lazy" />
      ) : (
        <div className="placeholder-image" />
      )}
    </div>
  );
}
```

### Bundle Optimization

```typescript
// Dynamic imports with webpack magic comments
const loadChart = () => import(
  /* webpackChunkName: "charts" */
  /* webpackPreload: true */
  './components/Chart'
);

// Tree-shakeable imports
// ❌ Bad - imports entire library
import _ from 'lodash';
const result = _.debounce(fn, 300);

// ✅ Good - imports only what's needed
import debounce from 'lodash-es/debounce';
const result = debounce(fn, 300);

// Conditional loading based on feature flags
async function loadFeature(featureName: string) {
  switch (featureName) {
    case 'analytics':
      return import(/* webpackChunkName: "analytics" */ './features/analytics');
    case 'reporting':
      return import(/* webpackChunkName: "reporting" */ './features/reporting');
    default:
      throw new Error(`Unknown feature: ${featureName}`);
  }
}
```

---

## Accessibility (WCAG 2.1 AA)

### Semantic HTML and ARIA

```typescript
// Accessible form with proper labeling
function AccessibleForm() {
  const [errors, setErrors] = useState<Record<string, string>>({});
  
  return (
    <form aria-label="Contact form">
      <div className="form-group">
        <label htmlFor="email">
          Email Address
          <span className="required" aria-label="required">*</span>
        </label>
        <input
          id="email"
          type="email"
          aria-required="true"
          aria-invalid={!!errors.email}
          aria-describedby={errors.email ? "email-error" : undefined}
        />
        {errors.email && (
          <span id="email-error" role="alert" className="error">
            {errors.email}
          </span>
        )}
      </div>
      
      <button type="submit">Submit</button>
    </form>
  );
}

// Accessible modal with focus management
function AccessibleModal({ isOpen, onClose, title, children }) {
  const modalRef = useRef<HTMLDivElement>(null);
  const previousActiveElement = useRef<HTMLElement | null>(null);
  
  useEffect(() => {
    if (isOpen) {
      previousActiveElement.current = document.activeElement as HTMLElement;
      modalRef.current?.focus();
    } else {
      previousActiveElement.current?.focus();
    }
  }, [isOpen]);
  
  if (!isOpen) return null;
  
  return (
    <div
      role="dialog"
      aria-modal="true"
      aria-labelledby="modal-title"
      ref={modalRef}
      tabIndex={-1}
      onKeyDown={(e) => {
        if (e.key === 'Escape') {
          onClose();
        }
      }}
    >
      <h2 id="modal-title">{title}</h2>
      {children}
      <button onClick={onClose}>Close</button>
    </div>
  );
}
```

### Keyboard Navigation

```typescript
// Custom keyboard navigation hook
function useKeyboardNavigation(items: string[]) {
  const [selectedIndex, setSelectedIndex] = useState(0);
  
  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      switch (e.key) {
        case 'ArrowDown':
          e.preventDefault();
          setSelectedIndex(prev => 
            prev < items.length - 1 ? prev + 1 : prev
          );
          break;
        case 'ArrowUp':
          e.preventDefault();
          setSelectedIndex(prev => prev > 0 ? prev - 1 : prev);
          break;
        case 'Home':
          e.preventDefault();
          setSelectedIndex(0);
          break;
        case 'End':
          e.preventDefault();
          setSelectedIndex(items.length - 1);
          break;
      }
    };
    
    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, [items.length]);
  
  return selectedIndex;
}

// Skip to main content link
function SkipToMain() {
  return (
    <a 
      href="#main-content" 
      className="skip-link"
      onFocus={(e) => e.currentTarget.classList.add('focused')}
      onBlur={(e) => e.currentTarget.classList.remove('focused')}
    >
      Skip to main content
    </a>
  );
}
```

### Screen Reader Support

```typescript
// Live regions for dynamic content
function LiveNotifications() {
  const [notifications, setNotifications] = useState<string[]>([]);
  
  return (
    <>
      {/* Polite announcements */}
      <div 
        role="status" 
        aria-live="polite" 
        aria-atomic="true"
        className="sr-only"
      >
        {notifications[0]}
      </div>
      
      {/* Assertive announcements for errors */}
      <div 
        role="alert" 
        aria-live="assertive" 
        aria-atomic="true"
        className="sr-only"
      >
        {errors.critical}
      </div>
    </>
  );
}

// Accessible data table
function AccessibleTable({ data, columns }) {
  return (
    <table role="table" aria-label="User data">
      <caption className="sr-only">
        Table showing user information with {columns.length} columns
      </caption>
      <thead>
        <tr role="row">
          {columns.map(col => (
            <th 
              key={col.id} 
              role="columnheader"
              scope="col"
              aria-sort={col.sortable ? col.sortDirection : undefined}
            >
              {col.label}
            </th>
          ))}
        </tr>
      </thead>
      <tbody>
        {data.map((row, index) => (
          <tr key={row.id} role="row" aria-rowindex={index + 2}>
            {columns.map(col => (
              <td key={col.id} role="cell">
                {row[col.field]}
              </td>
            ))}
          </tr>
        ))}
      </tbody>
    </table>
  );
}
```

---

## CSS/Styling

### Tailwind CSS (Recommended)

```typescript
// Tailwind with component variants using clsx
import clsx from 'clsx';

interface ButtonProps {
  variant?: 'primary' | 'secondary' | 'danger';
  size?: 'sm' | 'md' | 'lg';
  disabled?: boolean;
  children: React.ReactNode;
  onClick?: () => void;
}

function Button({ variant = 'primary', size = 'md', disabled, children, onClick }: ButtonProps) {
  const baseStyles = 'font-semibold rounded-lg transition-colors focus:outline-none focus:ring-2 focus:ring-offset-2';
  
  const variants = {
    primary: 'bg-blue-600 text-white hover:bg-blue-700 focus:ring-blue-500',
    secondary: 'bg-gray-200 text-gray-900 hover:bg-gray-300 focus:ring-gray-500',
    danger: 'bg-red-600 text-white hover:bg-red-700 focus:ring-red-500'
  };
  
  const sizes = {
    sm: 'px-3 py-1.5 text-sm',
    md: 'px-4 py-2 text-base',
    lg: 'px-6 py-3 text-lg'
  };
  
  return (
    <button
      className={clsx(
        baseStyles,
        variants[variant],
        sizes[size],
        disabled && 'opacity-50 cursor-not-allowed'
      )}
      disabled={disabled}
      onClick={onClick}
    >
      {children}
    </button>
  );
}

// Responsive design with Tailwind
function ResponsiveGrid() {
  return (
    <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4 p-4">
      {items.map(item => (
        <div 
          key={item.id}
          className="bg-white rounded-lg shadow-md p-6 hover:shadow-lg transition-shadow"
        >
          <h3 className="text-lg font-semibold mb-2">{item.title}</h3>
          <p className="text-gray-600">{item.description}</p>
        </div>
      ))}
    </div>
  );
}
```

### CSS Modules

```typescript
// Button.module.css
.button {
  font-weight: 600;
  border-radius: 0.5rem;
  transition: all 0.2s;
  padding: 0.5rem 1rem;
  
  &:focus {
    outline: none;
    box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.5);
  }
}

.primary {
  background-color: #3182ce;
  color: white;
  
  &:hover {
    background-color: #2c5282;
  }
}

.secondary {
  background-color: #e2e8f0;
  color: #2d3748;
  
  &:hover {
    background-color: #cbd5e0;
  }
}

// Button.tsx
import styles from './Button.module.css';

function Button({ variant = 'primary', children }) {
  return (
    <button className={`${styles.button} ${styles[variant]}`}>
      {children}
    </button>
  );
}
```

### CSS-in-JS (styled-components)

```typescript
import styled from 'styled-components';

// Theme definition
const theme = {
  colors: {
    primary: '#3182ce',
    secondary: '#e2e8f0',
    danger: '#e53e3e'
  },
  spacing: {
    sm: '0.5rem',
    md: '1rem',
    lg: '1.5rem'
  },
  breakpoints: {
    sm: '640px',
    md: '768px',
    lg: '1024px'
  }
};

// Styled components with props
const Button = styled.button<{ variant?: 'primary' | 'secondary' }>`
  font-weight: 600;
  border-radius: 0.5rem;
  padding: ${props => props.theme.spacing.sm} ${props => props.theme.spacing.md};
  background-color: ${props => props.theme.colors[props.variant || 'primary']};
  color: ${props => props.variant === 'secondary' ? '#2d3748' : 'white'};
  transition: all 0.2s;
  
  &:hover {
    opacity: 0.9;
    transform: translateY(-1px);
  }
  
  &:focus {
    outline: none;
    box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.5);
  }
  
  @media (min-width: ${props => props.theme.breakpoints.md}) {
    padding: ${props => props.theme.spacing.md} ${props => props.theme.spacing.lg};
  }
`;

// Dynamic styling based on props
const Card = styled.div<{ elevated?: boolean }>`
  background: white;
  border-radius: 0.5rem;
  padding: ${props => props.theme.spacing.lg};
  box-shadow: ${props => props.elevated 
    ? '0 10px 15px -3px rgba(0, 0, 0, 0.1)' 
    : '0 1px 3px 0 rgba(0, 0, 0, 0.1)'};
`;
```

---

## Testing Frontend

### React Testing Library

```typescript
// Component testing with RTL
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import userEvent from '@testing-library/user-event';

// Test user interactions
describe('LoginForm', () => {
  it('should handle form submission', async () => {
    const mockLogin = jest.fn();
    const user = userEvent.setup();
    
    render(<LoginForm onLogin={mockLogin} />);
    
    // Type into inputs
    await user.type(screen.getByLabelText(/email/i), 'test@example.com');
    await user.type(screen.getByLabelText(/password/i), 'password123');
    
    // Submit form
    await user.click(screen.getByRole('button', { name: /sign in/i }));
    
    // Assert
    await waitFor(() => {
      expect(mockLogin).toHaveBeenCalledWith({
        email: 'test@example.com',
        password: 'password123'
      });
    });
  });
  
  it('should show validation errors', async () => {
    render(<LoginForm />);
    
    // Submit empty form
    fireEvent.click(screen.getByRole('button', { name: /sign in/i }));
    
    // Check for error messages
    expect(await screen.findByText(/email is required/i)).toBeInTheDocument();
    expect(await screen.findByText(/password is required/i)).toBeInTheDocument();
  });
});

// Testing async components
describe('UserProfile', () => {
  it('should load and display user data', async () => {
    const mockUser = {
      id: '1',
      name: 'John Doe',
      email: 'john@example.com'
    };
    
    // Mock API call
    global.fetch = jest.fn(() =>
      Promise.resolve({
        ok: true,
        json: () => Promise.resolve(mockUser)
      })
    ) as jest.Mock;
    
    render(<UserProfile userId="1" />);
    
    // Check loading state
    expect(screen.getByText(/loading/i)).toBeInTheDocument();
    
    // Wait for data to load
    expect(await screen.findByText(mockUser.name)).toBeInTheDocument();
    expect(screen.getByText(mockUser.email)).toBeInTheDocument();
  });
});
```

### Component Testing Best Practices

```typescript
// Custom render with providers
import { ReactElement } from 'react';
import { render, RenderOptions } from '@testing-library/react';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { BrowserRouter } from 'react-router-dom';

const AllTheProviders = ({ children }: { children: React.ReactNode }) => {
  const queryClient = new QueryClient({
    defaultOptions: {
      queries: { retry: false },
    },
  });
  
  return (
    <QueryClientProvider client={queryClient}>
      <BrowserRouter>
        {children}
      </BrowserRouter>
    </QueryClientProvider>
  );
};

const customRender = (
  ui: ReactElement,
  options?: Omit<RenderOptions, 'wrapper'>
) => render(ui, { wrapper: AllTheProviders, ...options });

// Test with custom hooks
import { renderHook, act } from '@testing-library/react';

describe('useCounter', () => {
  it('should increment counter', () => {
    const { result } = renderHook(() => useCounter());
    
    expect(result.current.count).toBe(0);
    
    act(() => {
      result.current.increment();
    });
    
    expect(result.current.count).toBe(1);
  });
});
```

### Visual Regression Testing

```typescript
// Using Playwright for visual regression
import { test, expect } from '@playwright/test';

test.describe('Visual Regression', () => {
  test('homepage visual comparison', async ({ page }) => {
    await page.goto('/');
    await page.waitForLoadState('networkidle');
    
    // Take screenshot
    await expect(page).toHaveScreenshot('homepage.png', {
      fullPage: true,
      animations: 'disabled'
    });
  });
  
  test('component states', async ({ page }) => {
    await page.goto('/components/button');
    
    // Default state
    await expect(page.locator('[data-testid="button-default"]'))
      .toHaveScreenshot('button-default.png');
    
    // Hover state
    await page.hover('[data-testid="button-default"]');
    await expect(page.locator('[data-testid="button-default"]'))
      .toHaveScreenshot('button-hover.png');
    
    // Focus state
    await page.focus('[data-testid="button-default"]');
    await expect(page.locator('[data-testid="button-default"]'))
      .toHaveScreenshot('button-focus.png');
  });
});

// Storybook integration
import type { Meta, StoryObj } from '@storybook/react';

const meta: Meta<typeof Button> = {
  title: 'Components/Button',
  component: Button,
  parameters: {
    chromatic: { viewports: [320, 768, 1200] },
  },
  argTypes: {
    variant: {
      control: { type: 'select' },
      options: ['primary', 'secondary', 'danger'],
    },
  },
};

export default meta;
type Story = StoryObj<typeof meta>;

export const Default: Story = {
  args: {
    children: 'Click me',
  },
};

export const AllVariants: Story = {
  render: () => (
    <div className="space-y-4">
      <Button variant="primary">Primary</Button>
      <Button variant="secondary">Secondary</Button>
      <Button variant="danger">Danger</Button>
    </div>
  ),
};
```

---

## Build Tools

### Vite Configuration

```typescript
// vite.config.ts
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import { visualizer } from 'rollup-plugin-visualizer';
import viteCompression from 'vite-plugin-compression';
import { VitePWA } from 'vite-plugin-pwa';

export default defineConfig({
  plugins: [
    react(),
    
    // Bundle visualization
    visualizer({
      template: 'treemap',
      open: true,
      gzipSize: true,
      brotliSize: true,
    }),
    
    // Compression
    viteCompression({
      algorithm: 'brotliCompress',
      ext: '.br',
    }),
    
    // PWA support
    VitePWA({
      registerType: 'autoUpdate',
      manifest: {
        name: 'My App',
        short_name: 'MyApp',
        theme_color: '#ffffff',
      },
    }),
  ],
  
  build: {
    // Code splitting
    rollupOptions: {
      output: {
        manualChunks: {
          'react-vendor': ['react', 'react-dom', 'react-router-dom'],
          'ui-vendor': ['@headlessui/react', 'clsx'],
          'utils': ['date-fns', 'lodash-es'],
        },
      },
    },
    
    // Target modern browsers
    target: 'es2020',
    
    // Optimize CSS
    cssCodeSplit: true,
    
    // Source maps for production debugging
    sourcemap: true,
    
    // Chunk size warnings
    chunkSizeWarningLimit: 1000,
  },
  
  // Optimization
  optimizeDeps: {
    include: ['react', 'react-dom'],
    exclude: ['@vite/client', '@vite/env'],
  },
  
  // Development
  server: {
    port: 3000,
    open: true,
    cors: true,
  },
});
```

### Performance Monitoring

```typescript
// Web Vitals monitoring
import { onCLS, onFID, onFCP, onLCP, onTTFB } from 'web-vitals';

function sendToAnalytics(metric: any) {
  // Send to your analytics endpoint
  const body = JSON.stringify({
    name: metric.name,
    value: metric.value,
    rating: metric.rating,
    delta: metric.delta,
  });
  
  // Use `navigator.sendBeacon()` if available, falling back to `fetch()`
  if (navigator.sendBeacon) {
    navigator.sendBeacon('/analytics', body);
  } else {
    fetch('/analytics', { body, method: 'POST', keepalive: true });
  }
}

// Monitor Core Web Vitals
onCLS(sendToAnalytics);
onFID(sendToAnalytics);
onFCP(sendToAnalytics);
onLCP(sendToAnalytics);
onTTFB(sendToAnalytics);

// Custom performance marks
export function measureComponentPerformance(componentName: string) {
  return function decorator(target: any) {
    const originalRender = target.prototype.render;
    
    target.prototype.render = function(...args: any[]) {
      performance.mark(`${componentName}-render-start`);
      const result = originalRender.apply(this, args);
      performance.mark(`${componentName}-render-end`);
      
      performance.measure(
        `${componentName}-render`,
        `${componentName}-render-start`,
        `${componentName}-render-end`
      );
      
      return result;
    };
    
    return target;
  };
}
```

### Bundle Analysis

```bash
# Analyze bundle with source-map-explorer
npm install -D source-map-explorer
npm run build
npx source-map-explorer 'dist/assets/*.js'

# Webpack Bundle Analyzer (if using webpack)
npm install -D webpack-bundle-analyzer

# Vite visualizer (built into config above)
npm run build -- --mode analyze
```

---

## Summary

These best practices represent the cutting-edge of frontend development in 2025:

1. **React**: Embrace Server Components, Suspense, and concurrent features
2. **TypeScript**: Always use strict mode and leverage advanced type features
3. **State Management**: Choose Zustand for most projects, Redux Toolkit for complex apps
4. **Performance**: Strategic memoization, code splitting, and bundle optimization
5. **Accessibility**: Semantic HTML first, ARIA when needed, comprehensive keyboard support
6. **Styling**: Tailwind CSS for rapid development, CSS Modules for isolation
7. **Testing**: User-centric testing with RTL, visual regression for UI consistency
8. **Build Tools**: Vite for modern, fast builds with intelligent optimization

Remember: Start simple, measure performance, and optimize based on real data rather than assumptions.