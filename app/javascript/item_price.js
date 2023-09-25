function item_price() {
  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const addProfitDom = document.getElementById("profit");
  const tax = 0.1;
  
  if (priceInput) {
    priceInput.addEventListener("input", () => {
      const inputValue = priceInput.value;
      const taxAmount = Math.floor(inputValue * tax);
      addTaxDom.innerHTML = `${taxAmount}`;
      const profitAmount = Math.floor(inputValue - taxAmount);
      addProfitDom.innerHTML = `${profitAmount}`;
    });
  }
}

window.addEventListener('click', () => {
  item_price();
});