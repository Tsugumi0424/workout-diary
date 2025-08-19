// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load", () => {
  const toggles = [
    { iconId: "toggle-password", inputId: "user_password" },
    { iconId: "toggle-password-confirmation", inputId: "user_password_confirmation" }
  ];

  toggles.forEach(({ iconId, inputId }) => {
    const toggle = document.getElementById(iconId);
    const input = document.getElementById(inputId);

    if (toggle && input) {
      toggle.textContent = "∼";
      toggle.classList.add("tilted");
      toggle.classList.remove("open");

      toggle.addEventListener("click", () => {
        const isHidden = input.type === "password";
        input.type = isHidden ? "text" : "password";

        if (isHidden) {
          toggle.textContent = "𓁻";
          toggle.classList.remove("tilted");
          toggle.classList.add("open");
        } else {
          toggle.textContent = "∼";
          toggle.classList.remove("open");
          toggle.classList.add("tilted");
        }
      });
    }
  });
});














