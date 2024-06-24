const product = {}
product.rates = [
  {
    rate: 5,
    description: 'very good prodcut.',
    __v: 0
  },
  {
    rate: 3,
    description: 'not really that good.',
    __v: 0
  },
]

console.log(
  "total rates:",
  product.rates.reduce((acc, rateObject) => acc + rateObject.rate, 0)
);