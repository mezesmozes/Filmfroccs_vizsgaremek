    function switchTab(tabId) {
    // Védett profil funkció: ha nincs bejelentkezve, megnyitja a modalt
    if (tabId === 'profil' && !localStorage.getItem('currentUser')) {
      openAuthModal('login');
      return;
    }

    document.querySelectorAll('.tab-content').forEach(el => el.classList.remove('active'));
    document.querySelectorAll('.nav-btn').forEach(el => el.classList.remove('active'));
    
    const targetTab = document.getElementById(tabId);
    if (targetTab) targetTab.classList.add('active');

    const targetBtn = document.getElementById('btn-' + tabId);
    if (targetBtn) targetBtn.classList.add('active');
  }

  function openAuthModal(mode) {
    document.getElementById('auth-modal').classList.add('active');
    switchAuthTab(mode);
  }

  function closeAuthModal() {
    document.getElementById('auth-modal').classList.remove('active');
    document.getElementById('login-error').innerText = '';
    document.getElementById('reg-error').innerText = '';
  }

  function switchAuthTab(mode) {
    const loginForm = document.getElementById('login-form');
    const regForm = document.getElementById('register-form');
    const loginTabBtn = document.getElementById('tab-login-btn');
    const regTabBtn = document.getElementById('tab-register-btn');

    if (mode === 'login') {
      loginForm.classList.add('active');
      regForm.classList.remove('active');
      loginTabBtn.classList.add('active');
      regTabBtn.classList.remove('active');
    } else {
      regForm.classList.add('active');
      loginForm.classList.remove('active');
      regTabBtn.classList.add('active');
      loginTabBtn.classList.remove('active');
    }
  }

  function handleRegister(e) {
    e.preventDefault();
    const username = document.getElementById('reg-username').value.trim();
    const email = document.getElementById('reg-email').value.trim();
    const password = document.getElementById('reg-password').value;
    const errorEl = document.getElementById('reg-error');

    let users = JSON.parse(localStorage.getItem('users')) || [];

    if (users.some(u => u.username === username)) {
      errorEl.innerText = 'Ez a felhasználónév már foglalt!';
      return;
    }

    const newUser = { username, email, password };
    users.push(newUser);
    localStorage.setItem('users', JSON.stringify(users));

    localStorage.setItem('currentUser', JSON.stringify(newUser));
    updateUI();
    closeAuthModal();
    document.getElementById('register-form').reset();
  }

  function handleLogin(e) {
    e.preventDefault();
    const username = document.getElementById('login-username').value.trim();
    const password = document.getElementById('login-password').value;
    const errorEl = document.getElementById('login-error');

    let users = JSON.parse(localStorage.getItem('users')) || [];
    const user = users.find(u => (u.username === username || u.email === username) && u.password === password);

    if (user) {
      localStorage.setItem('currentUser', JSON.stringify(user));
      updateUI();
      closeAuthModal();
      document.getElementById('login-form').reset();
    } else {
      errorEl.innerText = 'Hibás felhasználónév vagy jelszó!';
    }
  }

  function logout() {
    localStorage.removeItem('currentUser');
    updateUI();
    switchTab('kezdolap');
  }

  function updateUI() {
    const currentUser = JSON.parse(localStorage.getItem('currentUser'));
    const navActions = document.getElementById('user-menu-wrapper');
    
    if (currentUser && navActions) {
      navActions.innerHTML = `
        <button class="icon-btn" onclick="toggleDropdown()"><i class="fa-solid fa-circle-user"></i></button>
        <div class="user-dropdown" id="user-dropdown">
          <div class="dropdown-header">${currentUser.username}</div>
          <a href="#" onclick="switchTab('profil'); hideDropdown();"><i class="fa-solid fa-user"></i> Profilom</a>
          <a href="#" onclick="logout(); hideDropdown();"><i class="fa-solid fa-right-from-bracket"></i> Kijelentkezés</a>
        </div>
      `;
      const profileName = document.getElementById('profile-name-display');
      if (profileName) {
        profileName.innerHTML = `${currentUser.username} <span style="font-size: 0.9rem; background: var(--primary-orange); padding: 2px 8px; border-radius: 12px; vertical-align: middle;">LVL 1</span>`;
      }
    } else if (navActions) {
      navActions.innerHTML = `
        <button class="btn-primary" onclick="openAuthModal('login')"><i class="fa-solid fa-right-to-bracket"></i> Bejelentkezés</button>
      `;
    }
  }

  function toggleDropdown() {
    const dropdown = document.getElementById('user-dropdown');
    if (dropdown) dropdown.classList.toggle('active');
  }

  function hideDropdown() {
    const dropdown = document.getElementById('user-dropdown');
    if (dropdown) dropdown.classList.remove('active');
  }

  window.addEventListener('DOMContentLoaded', updateUI);
