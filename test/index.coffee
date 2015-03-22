describe 'test index', ->
  it '$ exist', ->
    jasmine.getFixtures().fixturesPath = '/base'
    expect(typeof $ == 'function').toBe true
    indexHtml = readFixtures('public/index.html')
    indexHtml = indexHtml.replace(/<script.*?><\/script>/g, '').replace(/<!--.*?-->/g, '').replace(/\n/g, '')
    indexHtml = indexHtml.match(/<body>(.+)<\/body>/g)[0].replace(/<body>/, '').replace(/<\/body>/, '')
    loadFixtures('public/js/index.js')
