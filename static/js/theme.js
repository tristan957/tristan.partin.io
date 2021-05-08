function isDarkModeEnabled() {
  const siteTheme = window.localStorage.getItem("site-theme");
  return (
    (window.matchMedia &&
      window.matchMedia("(prefers-color-scheme: dark)").matches &&
      siteTheme !== "light") ||
    siteTheme === "dark"
  );
}

function switchTheme(dark) {
  if (dark) {
    document.documentElement.setAttribute("site-theme", "dark");
    window.localStorage.setItem("site-theme", "dark");
    darkModePreferred = true;
  } else {
    document.documentElement.setAttribute("site-theme", "light");
    window.localStorage.setItem("site-theme", "light");
    darkModePreferred = false;
  }
}

switchTheme(isDarkModeEnabled());

const themeButton = document.getElementById("theme-btn");
themeButton.addEventListener("click", () => switchTheme(!isDarkModeEnabled()));
