const state = {
  history: ["splash"],
  goal: "Maintain",
  mealsPerDay: 3,
  selectedPlan: null,
  subscriptionType: "chicken",
  subscriptionProtein: 150,
  subscriptionMeals: 3,
  addExtraCarbs: false,
  swapToSeafood: false,
  selectedMeal: null,
  proteinSizes: {},
  targets: null,
  pendingTargets: null,
};

const categories = {
  chicken: "Chicken",
  beef: "Beef",
  seafood: "Seafood",
  pasta: "Pasta",
  sandwich: "Sandwich",
};

const sides = [
  "رز أبيض",
  "رز تايلندي",
  "رز شعيرية",
  "رز مكسيكي",
  "رز برياني",
  "رز بخاري",
  "رز كبسة",
  "بطاطس مهروسة",
  "بطاطس حلوة مهروسة",
  "خضار مشوي",
  "خضار سوتيه",
];

const sauces = [
  "صوص فلفل حلو",
  "صوص أعشاب فرنسية",
  "صوص كاري",
  "صوص سموكي",
  "صوص مشروم",
  "صوص بافولو",
  "صوص بيستو",
  "صوص ماكروهب",
  "صوص حامض حلو حار",
  "صوص مكسيكي",
];

const meals = [
  m("دجاج فلفل حلو", "chicken", 485, 43, 46, 12, ["صدر دجاج", "صوص فلفل حلو", "رز أبيض", "خضار سوتيه"], ["#EF4444", "#7C2D12"], null, true),
  m("دجاج فرنسي / أعشاب فرنسية", "chicken", 510, 44, 42, 15, ["صدر دجاج", "أعشاب فرنسية", "رز تايلندي", "خضار مشوي"], ["#2DD4BF", "#0F766E"], "assets/images/meals/french_thyme_chicken.png", true),
  m("دجاج كاري", "chicken", 535, 45, 52, 14, ["صدر دجاج", "صوص كاري", "رز برياني", "خضار سوتيه"], ["#FACC15", "#A16207"], "assets/images/meals/curry_chicken.png", true),
  m("دجاج سموكي", "chicken", 500, 46, 43, 13, ["صدر دجاج", "صوص سموكي", "رز مكسيكي", "خضار مشوي"], ["#FB923C", "#7C2D12"], "assets/images/meals/smoky_chicken.png", true),
  m("دجاج مدخن", "chicken", 470, 47, 35, 12, ["دجاج مدخن", "بطاطس حلوة مهروسة", "خضار مشوي"], ["#94A3B8", "#334155"], null, true),
  m("دجاج صيني", "chicken", 520, 44, 55, 11, ["صدر دجاج", "تتبيلة صينية", "رز أبيض", "خضار سوتيه"], ["#38BDF8", "#1E3A8A"], "assets/images/meals/chinese_chicken.png", true),
  m("دجاج مشروم", "chicken", 525, 46, 44, 15, ["صدر دجاج", "صوص مشروم", "مكرونة", "سبانخ"], ["#A3E635", "#365314"], "assets/images/meals/mushroom_chicken.png", true),
  m("دجاج مشوي", "chicken", 455, 48, 34, 10, ["صدر دجاج مشوي", "رز أبيض", "خضار مشوي"], ["#22C55E", "#14532D"], "assets/images/meals/grilled_chicken.png", true),
  m("دجاج ماكروهب", "chicken", 540, 47, 50, 16, ["صدر دجاج", "صوص ماكروهب", "رز بخاري", "خضار سوتيه"], ["#02C3A6", "#00344A"], "assets/images/meals/macrohub_basil_chicken.png", true),
  m("دجاج الشيف", "chicken", 560, 46, 48, 18, ["صدر دجاج", "خلطة الشيف", "رز كبسة", "خضار مشوي"], ["#F97316", "#9A3412"], "assets/images/meals/chef_chicken.png", true),
  m("شيش طاووق", "chicken", 490, 45, 42, 13, ["شيش طاووق", "رز أبيض", "خضار مشوي"], ["#F43F5E", "#881337"], "assets/images/meals/shish_tawook.png", true),
  m("دجاج بافولو", "chicken", 515, 46, 40, 17, ["صدر دجاج", "صوص بافولو", "بطاطس مهروسة"], ["#FF6B35", "#7C2D12"], "assets/images/meals/buffalo_chicken.png", true),
  m("دجاج البستو", "chicken", 545, 44, 43, 20, ["صدر دجاج", "صوص بيستو", "رز تايلندي"], ["#34D399", "#047857"], "assets/images/meals/pesto_chicken.png", true),
  m("دجاج وماكروني", "chicken", 620, 46, 68, 18, ["دجاج", "ماكروني", "صوص خفيف"], ["#F59E0B", "#92400E"], "assets/images/meals/mac_and_cheese_chicken.png"),
  m("كرات اللحم", "beef", 610, 39, 48, 25, ["كرات لحم", "صلصة طماطم", "رز أبيض"], ["#EF4444", "#7F1D1D"], "assets/images/meals/meatballs.png", true),
  m("لحم مغربي", "beef", 635, 41, 52, 24, ["لحم", "بهارات مغربية", "رز برياني", "خضار"], ["#D97706", "#78350F"], "assets/images/meals/moroccan_tajin_beef.png", true),
  m("ستيك", "beef", 590, 48, 32, 26, ["ستيك", "بطاطس مهروسة", "خضار مشوي"], ["#991B1B", "#450A0A"], "assets/images/meals/tenderloin_steak.png", true),
  m("لحم بالقرع", "beef", 575, 40, 38, 24, ["لحم", "قرع", "رز أبيض"], ["#F97316", "#7C2D12"], "assets/images/meals/pumpkin_beef.png", true),
  m("لحم سموكي", "beef", 620, 42, 56, 20, ["لحم", "صوص سموكي", "رز بخاري", "خضار مشوي"], ["#FB923C", "#7F1D1D"], "assets/images/meals/smoky_beef.png", true),
  m("روبيان حامض حلو حار", "seafood", 455, 36, 50, 9, ["روبيان", "صوص حامض حلو حار", "رز أبيض"], ["#38BDF8", "#075985"], "assets/images/meals/sweet_sour_spicy_shrimp.png", true),
  m("روبيان مكسيكي", "seafood", 470, 37, 48, 11, ["روبيان", "صوص مكسيكي", "رز مكسيكي"], ["#22D3EE", "#155E75"], "assets/images/meals/mexican_shrimp.png", true),
  m("سمكة فيليه", "seafood", 430, 39, 34, 11, ["سمكة فيليه", "خضار مشوي", "بطاطس حلوة مهروسة"], ["#60A5FA", "#1D4ED8"], null, true),
  m("سمكة سالمون", "seafood", 560, 42, 28, 28, ["سالمون", "خضار سوتيه", "بطاطس مهروسة"], ["#FB7185", "#9F1239"], "assets/images/meals/salmon.png", true),
  m("فوتشيني مع دجاج", "pasta", 690, 42, 76, 24, ["فوتشيني", "دجاج", "صوص كريمي"], ["#FDE68A", "#92400E"], "assets/images/meals/fettuccine_pasta.png"),
  m("بيستو باستا مع دجاج", "pasta", 665, 41, 70, 25, ["باستا", "دجاج", "صوص بيستو"], ["#86EFAC", "#166534"], "assets/images/meals/pesto_pasta.png"),
  m("ريد باستا مع دجاج", "pasta", 640, 40, 74, 19, ["باستا", "دجاج", "صوص أحمر"], ["#F87171", "#991B1B"], "assets/images/meals/red_pasta.png"),
  m("بنك باستا مع دجاج", "pasta", 675, 41, 72, 23, ["باستا", "دجاج", "صوص بنك"], ["#F9A8D4", "#9D174D"], "assets/images/meals/pink_pasta.png"),
  m("ساندويتش دجاج بيستو", "sandwich", 520, 35, 48, 18, ["خبز", "دجاج", "صوص بيستو"], ["#4ADE80", "#15803D"], "assets/images/meals/chicken_pesto_sandwich.png"),
  m("ساندويتش ماكروهب", "sandwich", 540, 36, 50, 19, ["خبز", "دجاج", "صوص ماكروهب"], ["#02C3A6", "#00344A"], null),
  m("كلوب دجاج", "sandwich", 560, 38, 52, 20, ["خبز", "دجاج", "خس", "طماطم"], ["#FBBF24", "#92400E"], "assets/images/meals/chicken_club.png"),
  m("كلوب تونة", "sandwich", 500, 34, 46, 17, ["خبز", "تونة", "خضار"], ["#38BDF8", "#0F766E"], null),
  m("كلوب البيض", "sandwich", 480, 28, 44, 20, ["خبز", "بيض", "خضار"], ["#FDE047", "#A16207"], null),
  m("كاساديا الدجاج", "sandwich", 610, 40, 54, 24, ["تورتيلا", "دجاج", "جبن", "صوص خفيف"], ["#F59E0B", "#B45309"], null),
  m("ساندويتش الحلومي", "sandwich", 520, 26, 42, 27, ["خبز", "حلومي", "خضار"], ["#EAB308", "#854D0E"], "assets/images/meals/halloumi_sandwich.png"),
];

const goals = ["Lose Fat", "Maintain", "Build Muscle", "Custom Macros"];
const subscriptionTypes = {
  chicken: { title: "Chicken Plan", ar: "اشتراك الدجاج" },
  chickenBeef: { title: "Chicken + Beef Plan", ar: "اشتراك الدجاج مع اللحم" },
};

const subscriptionPrices = {
  chicken: {
    100: { 1: 480, 2: 875, 3: 1275 },
    150: { 1: 575, 2: 1075, 3: 1525 },
    200: { 1: 675, 2: 1225, 3: 1725 },
  },
  chickenBeef: {
    100: { 1: 575, 2: 1175, 3: 1500 },
    150: { 1: 725, 2: 1300, 3: 1825 },
    200: { 1: 875, 2: 1525, 3: 2175 },
  },
};

const seafoodSwapFees = {
  chicken: { 100: 20, 150: 25, 200: 30 },
  chickenBeef: { 100: 15, 150: 20, 200: 25 },
};

const extraCarbPrices = { 1: 70, 2: 130, 3: 200 };

function m(name, category, calories, protein, carbs, fat, ingredients, colors, image, supportsProteinSizing = false) {
  return { name, category, calories, protein, carbs, fat, ingredients, colors, image, supportsProteinSizing };
}

function macrosFor(mealItem, size = 150) {
  if (!mealItem.supportsProteinSizing || size === 150) return mealItem;
  const adjustedProtein = Math.round(mealItem.protein * (size / 150));
  const proteinDelta = adjustedProtein - mealItem.protein;
  return {
    ...mealItem,
    calories: mealItem.calories + (proteinDelta * 4),
    protein: adjustedProtein,
  };
}

function route(id, push = true) {
  document.querySelectorAll(".screen").forEach((screen) => screen.classList.toggle("active", screen.id === id));
  if (push && state.history[state.history.length - 1] !== id) state.history.push(id);
  document.getElementById("bottomNav").classList.toggle("visible", ["home", "meals", "subscriptions", "profile"].includes(id));
  document.querySelectorAll(".bottom-nav button").forEach((button) => button.classList.toggle("active", button.dataset.tab === id));
  if (id === "plans") renderPlans();
  if (id === "calculator") renderCalculator();
  if (id === "meals") renderMeals();
  if (id === "home") renderHome();
  if (id === "checkout") renderCheckout();
  window.scrollTo({ top: 0, behavior: "smooth" });
}

function renderCalculator() {
  const goalSelect = document.getElementById("calcGoal");
  if (goalSelect && ["Lose Fat", "Maintain", "Build Muscle"].includes(state.goal)) {
    goalSelect.value = state.goal;
  }
  if (!state.pendingTargets) document.getElementById("calculatorResult").innerHTML = "";
}

function back() {
  state.history.pop();
  route(state.history[state.history.length - 1] || "splash", false);
}

function renderGoals() {
  const root = document.getElementById("goalOptions");
  root.innerHTML = goals.map((goal) => `<button class="option-card ${goal === state.goal ? "selected" : ""}" data-goal="${goal}"><strong>${goal}</strong><p class="muted">Personalized macros and meal rhythm.</p></button>`).join("");
}

function renderMealCounts() {
  const root = document.getElementById("mealCountOptions");
  root.innerHTML = [1, 2, 3].map((count) => {
    const label = `${count} meal${count === 1 ? "" : "s"} per day`;
    return `<button class="meal-count ${count === state.mealsPerDay ? "selected" : ""}" data-count="${count}"><span>🍽</span><strong>${label}</strong></button>`;
  }).join("");
}

function calculateTargets() {
  const gender = document.getElementById("calcGender").value;
  const age = Number(document.getElementById("calcAge").value);
  const height = Number(document.getElementById("calcHeight").value);
  const weight = Number(document.getElementById("calcWeight").value);
  const activity = document.getElementById("calcActivity").value;
  const goal = document.getElementById("calcGoal").value;
  if (!age || !height || !weight || age <= 0 || height <= 0 || weight <= 0) {
    document.getElementById("calculatorResult").innerHTML = `<div class="glass-card"><p class="muted">Please enter valid age, height, and weight.</p></div>`;
    return;
  }

  const multipliers = { Sedentary: 1.2, Light: 1.375, Moderate: 1.55, Active: 1.725, "Very Active": 1.9 };
  const bmr = gender === "Male"
    ? (10 * weight) + (6.25 * height) - (5 * age) + 5
    : (10 * weight) + (6.25 * height) - (5 * age) - 161;
  const tdee = bmr * multipliers[activity];
  const calories = Math.round(goal === "Lose Fat" ? tdee - 400 : goal === "Build Muscle" ? tdee + 300 : tdee);
  const protein = Math.round(weight * (goal === "Maintain" ? 1.8 : 2.0));
  const proteinCalories = protein * 4;
  const fatCalories = calories * 0.25;
  const fat = Math.round(fatCalories / 9);
  const carbs = Math.max(0, Math.round((calories - proteinCalories - fatCalories) / 4));
  const suggestedMeals = calories < 1800 ? 2 : calories <= 2400 ? 2 : 3;

  state.pendingTargets = { calories, protein, carbs, fat, suggestedMeals, goal };
  renderCalculatorResult();
}

function renderCalculatorResult() {
  const targets = state.pendingTargets;
  if (!targets) return;
  document.getElementById("calculatorResult").innerHTML = `
    <div class="glass-card result-card">
      <span class="eyebrow">Estimated Targets / الأرقام التقريبية</span>
      <div class="summary-row"><span>Estimated Calories / السعرات التقريبية</span><strong>${targets.calories} kcal</strong></div>
      <div class="summary-row"><span>Protein target</span><strong>${targets.protein}g</strong></div>
      <div class="summary-row"><span>Carbs target</span><strong>${targets.carbs}g</strong></div>
      <div class="summary-row"><span>Fat target</span><strong>${targets.fat}g</strong></div>
      <p class="pill">${targets.calories < 1800 ? "Suggested: 1 or 2 meals per day" : `Suggested: ${targets.suggestedMeals} meals per day`}</p>
      <p class="muted">This is an estimated calculation and may vary based on individual needs.<br>هذا حساب تقريبي وقد يختلف حسب احتياج كل شخص.</p>
      <button class="primary" data-use-targets>Use These Targets / استخدم هذه الأرقام</button>
    </div>
  `;
}

function renderPlans() {
  state.subscriptionMeals = Math.min(Math.max(state.subscriptionMeals || state.mealsPerDay || 2, 1), 3);
  document.getElementById("planSubtitle").textContent = "Choose a MacroHub subscription. جميع الاشتراكات تشمل 100-200 جرام كارب.";
  const selected = currentSubscription();
  const targetSummary = state.targets ? `
    <div class="glass-card">
      <span class="eyebrow">Calculator Targets / نتائج الحاسبة</span>
      <p class="muted">${state.targets.calories} kcal - Protein ${state.targets.protein}g - Carbs ${state.targets.carbs}g - Fat ${state.targets.fat}g</p>
      <p class="pill">${state.targets.calories < 1800 ? "Suggested: 1 or 2 meals per day" : `Suggested: ${state.targets.suggestedMeals} meals per day`}</p>
    </div>
  ` : "";
  document.getElementById("plansList").innerHTML = `
    ${targetSummary}
    <div class="glass-card">
      <span class="eyebrow">Subscription type / نوع الاشتراك</span>
      <div class="choice-grid">
        ${Object.entries(subscriptionTypes).map(([key, value]) => `<button class="chip ${state.subscriptionType === key ? "selected" : ""}" data-sub-type="${key}">${value.title}<br>${value.ar}</button>`).join("")}
      </div>
    </div>
    <div class="glass-card">
      <span class="eyebrow">Protein size / حجم البروتين</span>
      <div class="choice-grid">${[100, 150, 200].map((value) => `<button class="chip ${state.subscriptionProtein === value ? "selected" : ""}" data-sub-protein="${value}">${value}g</button>`).join("")}</div>
    </div>
    <div class="glass-card">
      <span class="eyebrow">Meals per day / عدد الوجبات يوميًا</span>
      <div class="choice-grid">${[1, 2, 3].map((value) => `<button class="chip ${state.subscriptionMeals === value ? "selected" : ""}" data-sub-meals="${value}">${value}</button>`).join("")}</div>
    </div>
    <div class="glass-card">
      <span class="eyebrow">Add-ons / الإضافات</span>
      <button class="option-card ${state.addExtraCarbs ? "selected" : ""}" data-toggle-extra-carbs>
        <strong>Add extra carbs / إضافة كارب</strong>
        <p class="muted">+${extraCarbPrices[state.subscriptionMeals]} SAR</p>
      </button>
      <button class="option-card ${state.swapToSeafood ? "selected" : ""}" data-toggle-seafood>
        <strong>Swap to seafood meal / تبديل إلى وجبة بحرية</strong>
        <p class="muted">+${seafoodSwapFees[state.subscriptionType][state.subscriptionProtein]} SAR</p>
      </button>
    </div>
    <div class="glass-card">
      <p class="muted">جميع الاشتراكات تشمل 100-200 جرام كارب.</p>
      <div class="summary-row"><span>Base subscription</span><strong>${selected.basePrice} SAR</strong></div>
      ${state.addExtraCarbs ? `<div class="summary-row"><span>Extra carbs</span><strong>${selected.extraCarbsPrice} SAR</strong></div>` : ""}
      ${state.swapToSeafood ? `<div class="summary-row"><span>Seafood swap</span><strong>${selected.seafoodSwapFee} SAR</strong></div>` : ""}
      <div class="summary-row"><span>Final price</span><strong class="pill">${selected.totalPrice} SAR</strong></div>
      <button class="primary" data-plan>Continue to Checkout</button>
    </div>
  `;
}

function currentSubscription() {
  const basePrice = subscriptionPrices[state.subscriptionType][state.subscriptionProtein][state.subscriptionMeals];
  const extraCarbsPrice = state.addExtraCarbs ? extraCarbPrices[state.subscriptionMeals] : 0;
  const seafoodSwapFee = state.swapToSeafood ? seafoodSwapFees[state.subscriptionType][state.subscriptionProtein] : 0;
  return {
    type: subscriptionTypes[state.subscriptionType],
    protein: state.subscriptionProtein,
    meals: state.subscriptionMeals,
    basePrice,
    extraCarbsPrice,
    seafoodSwapFee,
    totalPrice: basePrice + extraCarbsPrice + seafoodSwapFee,
    addOns: [
      ...(state.addExtraCarbs ? [`Add extra carbs / إضافة كارب: ${extraCarbsPrice} SAR`] : []),
      ...(state.swapToSeafood ? [`Swap to seafood meal / تبديل إلى وجبة بحرية: ${seafoodSwapFee} SAR`] : []),
    ],
  };
}

function mealCard(item, index) {
  return `
    <button class="meal-card" data-meal="${index}">
      ${mealArt(item)}
      <div class="meal-title-row"><h3>${item.name}</h3><span class="pill">${item.calories} kcal</span></div>
      <span class="chip selected">${categories[item.category]}</span>
      <div class="macro-row">
        <div><span>Protein</span><strong>${item.protein}g</strong></div>
        <div><span>Carbs</span><strong>${item.carbs}g</strong></div>
        <div><span>Fat</span><strong>${item.fat}g</strong></div>
      </div>
    </button>
  `;
}

function renderMeals() {
  const root = document.getElementById("mealsList");
  root.classList.add("desktop-grid");
  root.innerHTML = meals.map(mealCard).join("");
}

function renderMealDetails() {
  const item = meals[state.selectedMeal];
  const size = state.proteinSizes[state.selectedMeal] ?? 150;
  const macro = macrosFor(item, size);
  const proteinSizeSection = item.supportsProteinSizing ? `
    <div class="glass-card">
      <span class="eyebrow">Protein Size</span>
      <p class="muted">Available only for this ready meal. Sides and sauces are fixed as part of the meal.</p>
      <div class="choice-grid">
        ${[100, 150, 200].map((value) => `<button class="chip ${value === size ? "selected" : ""}" data-protein-size="${value}">${value}g</button>`).join("")}
      </div>
    </div>
  ` : "";

  document.getElementById("mealDetailsContent").innerHTML = `
    ${mealArt(item, "large")}
    <div class="meal-title-row"><h2>${item.name}</h2><span class="pill">${categories[item.category]}</span></div>
    <p class="pill">${macro.calories} calories</p>
    <div class="macro-row">
      <div><span>Protein</span><strong>${macro.protein}g</strong></div>
      <div><span>Carbs</span><strong>${macro.carbs}g</strong></div>
      <div><span>Fat</span><strong>${macro.fat}g</strong></div>
    </div>
    ${proteinSizeSection}
    <h3>Ingredients</h3>
    <div class="choice-grid">${item.ingredients.map((ingredient) => `<span class="chip">${ingredient}</span>`).join("")}</div>
    <button class="primary" data-toast>Add to Plan</button>
  `;
}

function renderHome() {
  const selected = state.selectedPlan ?? currentSubscription();
  const subscription = document.getElementById("dashboardSubscription");
  subscription.innerHTML = `
    <span class="eyebrow">Client Subscription</span>
    <h3>${selected.type.title}</h3>
    <p>${selected.protein}g protein - ${selected.meals} meals daily - renews in 18 days</p>
    ${state.targets ? `<p class="pill">${state.targets.calories} kcal target - suggested ${state.targets.suggestedMeals} meals/day</p>` : ""}
  `;
  const targets = state.targets ?? { protein: 150, carbs: 180, fat: 55, calories: null };
  document.getElementById("dashboardCalories").textContent = targets.calories
    ? `${targets.calories} kcal estimated target`
    : "Daily target based on the active plan.";
  document.getElementById("dashboardMacros").innerHTML = `
    <div><span>Protein</span><strong>119 / ${targets.protein}g</strong></div>
    <div><span>Carbs</span><strong>136 / ${targets.carbs}g</strong></div>
    <div><span>Fat</span><strong>35 / ${targets.fat}g</strong></div>
  `;
  document.getElementById("todayMeals").innerHTML = meals.slice(0, 3).map((item) => {
    return `<div class="today-item">${thumbArt(item)}<strong>${item.name}</strong><span class="muted">${item.calories} kcal</span></div>`;
  }).join("");
}

function mealArt(item, size = "") {
  const large = size === "large" ? " large" : "";
  const image = item.image ? `<img src="${item.image}" alt="${item.name}">` : `<span>🍽</span>`;
  return `<div class="meal-art${large}" style="background:linear-gradient(135deg, ${item.colors[0]}, ${item.colors[1]})">${image}<i></i></div>`;
}

function thumbArt(item) {
  const image = item.image ? `<img src="${item.image}" alt="${item.name}">` : "🍽";
  return `<div class="thumb" style="background:linear-gradient(135deg, ${item.colors[0]}, ${item.colors[1]})">${image}</div>`;
}

function renderCheckout() {
  const selected = state.selectedPlan ?? currentSubscription();
  document.getElementById("checkoutSummary").innerHTML = `
    <div class="glass-card">
      <div class="summary-row"><span>Subscription type</span><strong>${selected.type.title}<br>${selected.type.ar}</strong></div>
      <div class="summary-row"><span>Protein size</span><strong>${selected.protein}g</strong></div>
      <div class="summary-row"><span>Meals per day</span><strong>${selected.meals}</strong></div>
      <div class="summary-row"><span>Add-ons</span><strong>${selected.addOns.length ? selected.addOns.join("<br>") : "No add-ons"}</strong></div>
      <div class="summary-row"><span>Duration</span><strong>Monthly subscription</strong></div>
      <div class="summary-row"><span>Address</span><strong>Riyadh, Saudi Arabia</strong></div>
      <div class="summary-row"><span>Payment</span><strong>Visa ending 4242</strong></div>
    </div>
    <div class="glass-card">
      <div class="summary-row"><span>Base subscription</span><strong>${selected.basePrice} SAR</strong></div>
      ${selected.extraCarbsPrice ? `<div class="summary-row"><span>Extra carbs</span><strong>${selected.extraCarbsPrice} SAR</strong></div>` : ""}
      ${selected.seafoodSwapFee ? `<div class="summary-row"><span>Seafood swap</span><strong>${selected.seafoodSwapFee} SAR</strong></div>` : ""}
      <div class="summary-row"><span>Final price</span><strong class="pill">${selected.totalPrice} SAR</strong></div>
    </div>
  `;
}

document.addEventListener("click", (event) => {
  const target = event.target.closest("button");
  if (!target) return;
  if (target.dataset.route === "plans") {
    state.subscriptionMeals = Math.min(Math.max(state.mealsPerDay || 3, 1), 3);
  }
  if (target.dataset.route) route(target.dataset.route);
  if (target.dataset.back !== undefined) back();
  if (target.dataset.tab) route(target.dataset.tab);
  if (target.dataset.goal) { state.goal = target.dataset.goal; renderGoals(); }
  if (target.dataset.count) {
    state.mealsPerDay = Math.min(Math.max(Number(target.dataset.count), 1), 3);
    state.subscriptionMeals = state.mealsPerDay;
    renderMealCounts();
  }
  if (target.dataset.calculate !== undefined) calculateTargets();
  if (target.dataset.useTargets !== undefined && state.pendingTargets) {
    state.targets = state.pendingTargets;
    state.mealsPerDay = state.targets.suggestedMeals;
    state.subscriptionMeals = state.targets.suggestedMeals;
    renderMealCounts();
    route("mealsPerDay");
  }
  if (target.dataset.skipCalculator !== undefined) route("mealsPerDay");
  if (target.dataset.subType) { state.subscriptionType = target.dataset.subType; renderPlans(); }
  if (target.dataset.subProtein) { state.subscriptionProtein = Number(target.dataset.subProtein); renderPlans(); }
  if (target.dataset.subMeals) { state.subscriptionMeals = Number(target.dataset.subMeals); renderPlans(); }
  if (target.dataset.toggleExtraCarbs !== undefined) { state.addExtraCarbs = !state.addExtraCarbs; renderPlans(); }
  if (target.dataset.toggleSeafood !== undefined) { state.swapToSeafood = !state.swapToSeafood; renderPlans(); }
  if (target.dataset.plan !== undefined) { state.selectedPlan = currentSubscription(); route("checkout"); }
  if (target.dataset.meal) { state.selectedMeal = Number(target.dataset.meal); renderMealDetails(); route("mealDetails"); }
  if (target.dataset.proteinSize) {
    state.proteinSizes[state.selectedMeal] = Number(target.dataset.proteinSize);
    renderMealDetails();
  }
  if (target.dataset.toast !== undefined) {
    target.textContent = "Added";
    setTimeout(() => target.textContent = "Add to Plan", 900);
  }
});

renderGoals();
renderMealCounts();
renderMeals();
renderHome();
