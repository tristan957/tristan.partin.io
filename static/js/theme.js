function isDarkModeEnabled() {
  const siteThemeFromStorage = window.localStorage.getItem("site-theme");
  return (
    (window.matchMedia &&
      window.matchMedia("(prefers-color-scheme: dark)").matches &&
      siteThemeFromStorage !== "light") ||
    siteThemeFromStorage === "dark"
  );
}

function switchTheme(theme) {
  if (theme === "dark") {
    document.documentElement.setAttribute("site-theme", "dark");
    window.localStorage.setItem("site-theme", "dark");
  } else {
    document.documentElement.setAttribute("site-theme", "light");
    window.localStorage.setItem("site-theme", "light");
  }
}

function overrideTheme(button) {
  if (!darkModePreferred) {
    darkModePreferred = true;
    button.innerHTML = "Light Theme";
    switchTheme("dark");
  } else {
    darkModePreferred = false;
    button.innerHTML = "Dark Theme";
    switchTheme("light");
  }
}

let darkModePreferred = isDarkModeEnabled();

switchTheme(darkModePreferred ? "dark" : "light");

const themeButton = document.getElementById("theme-btn");
themeButton.innerHTML = darkModePreferred ? "Light Theme" : "Dark Theme";
themeButton.addEventListener("click", (ev) => overrideTheme(ev.target));
